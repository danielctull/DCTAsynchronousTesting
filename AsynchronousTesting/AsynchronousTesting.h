//
//  AsynchronousTesting.h
//  AsynchronousTesting
//
//  Created by Daniel Tull on 10/07/2014.
//  Copyright (c) 2014 Daniel Tull. All rights reserved.
//

@import Foundation;

@interface AsynchronousTesting : NSObject

+ (void)performAsynchronousOperationWithCompletion:(void(^)(BOOL))completion;

@end
