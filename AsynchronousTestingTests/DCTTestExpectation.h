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

@compatibility_alias XCTestExpectation DCTTestExpectation;
