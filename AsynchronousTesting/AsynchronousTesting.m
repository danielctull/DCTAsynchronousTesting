//
//  AsynchronousTesting.m
//  AsynchronousTesting
//
//  Created by Daniel Tull on 10/07/2014.
//  Copyright (c) 2014 Daniel Tull. All rights reserved.
//

#import "AsynchronousTesting.h"

@implementation AsynchronousTesting

+ (void)performAsynchronousOperationWithCompletion:(void(^)(BOOL))completion {
	dispatch_after(0.3, dispatch_get_main_queue(), ^{
		completion(YES);
	});
}

@end
