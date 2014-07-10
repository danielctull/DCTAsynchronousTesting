# DCTAsynchronousTesting

DCTAsynchronousTesting provides compatibility code for the new Xcode 6 asynchronous testing methods in XCTest.

## Usage

* Clone this repository or add as a submodule and add the files from the `DCTAsynchronousTesting` directory into your test target.
* Add `#import "XCTestCase+DCTAsynchronousTesting.h"` to the top of test classes you want to perform asynchronous testing.
* Implement your test! An example is shown below.

``` objective-c
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

```

## License

Copyright (c) 2014 Daniel Tull. All rights reserved.
 
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
 
* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 
* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 
* Neither the name of the author nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.