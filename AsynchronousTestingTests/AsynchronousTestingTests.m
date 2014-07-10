//
//  AsynchronousTestingTests.m
//  AsynchronousTestingTests
//
//  Created by Daniel Tull on 10/07/2014.
//  Copyright (c) 2014 Daniel Tull. All rights reserved.
//

@import XCTest;
#import <AsynchronousTesting/AsynchronousTesting.h>
#import "XCTestCase+DCTAsynchronousTesting.h"

@interface AsynchronousTestingTests : XCTestCase
@end

@implementation AsynchronousTestingTests

- (void)testExample {

	XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
	[AsynchronousTesting performAsynchronousOperationWithCompletion:^(BOOL success) {
		XCTAssertTrue(success, @"Operation should have succeeded.");
		[expectation fulfill];
	}];

	[self waitForExpectationsWithTimeout:2 handler:nil];
}

@end
