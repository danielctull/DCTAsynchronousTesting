//
//  XCTestCase+DCTAsynchronousTesting.h
//  DCTAsynchronousTesting
//
//  Created by Daniel Tull on 09.07.2014.
//  Copyright (c) 2014 Daniel Tull. All rights reserved.
//

@import XCTest;
#import "DCTTestExpectation.h"

@interface XCTestCase (DCTAsynchronousTesting)

- (XCTestExpectation *)expectationWithDescription:(NSString *)description;

- (void)waitForExpectationsWithTimeout:(NSTimeInterval)timeout handler:(void(^)(NSError *error))handler;

@end
