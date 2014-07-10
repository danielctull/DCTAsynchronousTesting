//
//  XCTestCase+DCTAsynchronousTesting.m
//  DCTAsynchronousTesting
//
//  Created by Daniel Tull on 09.07.2014.
//  Copyright (c) 2014 Daniel Tull. All rights reserved.
//

@import ObjectiveC.runtime;
#import "XCTestCase+DCTAsynchronousTesting.h"

static void *DCTAsynchronousTestingExpectations = &DCTAsynchronousTestingExpectations;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation XCTestCase (DCTAsynchronousTesting)
#pragma clang diagnostic pop

+ (void)load {

	SEL expectationWithDescription = @selector(expectationWithDescription:);
	if ([self instancesRespondToSelector:expectationWithDescription]) return; // We're on Xcode 6

	SEL waitForExpectationsWithTimeoutHandler = @selector(waitForExpectationsWithTimeout:handler:);
	SEL dct_expectationWithDescription = @selector(dct_expectationWithDescription:);
	SEL dct_waitForExpectationsWithTimeoutHandler = @selector(dct_waitForExpectationsWithTimeout:handler:);

	[self dct_addMethodForSelector:expectationWithDescription implementationSelector:dct_expectationWithDescription];
	[self dct_addMethodForSelector:waitForExpectationsWithTimeoutHandler implementationSelector:dct_waitForExpectationsWithTimeoutHandler];
}

+ (void)dct_addMethodForSelector:(SEL)newSelector implementationSelector:(SEL)implementationSelector {
	IMP implementation = class_getMethodImplementation(self, implementationSelector);
	Method method = class_getInstanceMethod(self, implementationSelector);
	const char *typeEncoding = method_getTypeEncoding(method);
	class_addMethod(self, newSelector, implementation, typeEncoding);
}

- (NSMutableArray *)dct_expectations {

	NSMutableArray *expectations = objc_getAssociatedObject(self, DCTAsynchronousTestingExpectations);
	if (!expectations) {
		expectations = [NSMutableArray new];
		objc_setAssociatedObject(self, DCTAsynchronousTestingExpectations, expectations, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}

	return expectations;
}

- (DCTTestExpectation *)dct_expectationWithDescription:(NSString *)description {

	NSMutableArray *expectations = [self dct_expectations];

	DCTTestExpectation *expectation = [[DCTTestExpectation alloc] initWithDescription:description];
	[expectations addObject:expectation];

	__weak DCTTestExpectation *weakExpectation = expectation;
	expectation.completion = ^{
		[expectations removeObject:weakExpectation];
	};

	return expectation;
}

- (void)dct_waitForExpectationsWithTimeout:(NSTimeInterval)timeout handler:(void(^)(NSError *error))handler {

	dispatch_group_t group = dispatch_group_create();

	NSMutableArray *expectations = [self dct_expectations];
	for (DCTTestExpectation *expectation in expectations) {
		dispatch_group_enter(group);

		__weak DCTTestExpectation *weakExpectation = expectation;
		expectation.completion = ^{
			[expectations removeObject:weakExpectation];
			dispatch_group_leave(group);
		};
	}

	NSArray *descriptions = [expectations valueForKey:@"expectationDescription"];
	NSString *description = [descriptions componentsJoinedByString:@", "];

	__block BOOL finished = NO;
	dispatch_group_notify(group, dispatch_get_main_queue(), ^{
		finished = YES;
	});

	NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeout];
	while (!finished && [timeoutDate timeIntervalSinceNow] > 0) {
		[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:timeoutDate];
	}

	XCTAssertTrue(finished, @"Asynchronous wait failed. Exceeded timeout of %@ seconds, with expectations: %@", @(timeout), description);

	[expectations removeAllObjects];

	if (!handler) return;

	NSError *error = finished ? nil : [NSError errorWithDomain:@"dctTestExpectation" code:0 userInfo:@{NSLocalizedDescriptionKey : @"Timeout reached."}];
	handler(error);
}

@end
