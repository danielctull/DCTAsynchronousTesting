//
//  DCTTestExpectation.m
//  DCTAsynchronousTesting
//
//  Created by Daniel Tull on 09.07.2014.
//  Copyright (c) 2014 Daniel Tull. All rights reserved.
//

#import "DCTTestExpectation.h"

@implementation DCTTestExpectation

- (instancetype)initWithDescription:(NSString *)description {
	self = [super init];
	if (!self) return nil;
	_expectationDescription = [description copy];
	return self;
}

- (void)fulfill {
	if (self.completion) self.completion();
}

- (NSString *)description {
	return [NSString stringWithFormat:@"<%@: %p; %@>",
			NSStringFromClass([self class]),
			self,
			self.expectationDescription];
}

@end
