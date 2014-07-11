//
//  DCTTestExpectation.h
//  DCTAsynchronousTesting
//
//  Created by Daniel Tull on 09.07.2014.
//  Copyright (c) 2014 Daniel Tull. All rights reserved.
//

@import Foundation;

@interface DCTTestExpectation : NSObject

- (instancetype)initWithDescription:(NSString *)description;
@property (nonatomic, readonly) NSString *expectationDescription;
@property (nonatomic, copy) void (^completion)();

- (void)fulfill;

@end

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 80000
@compatibility_alias XCTestExpectation DCTTestExpectation;
#endif