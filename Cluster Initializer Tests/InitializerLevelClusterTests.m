//
//  InitializerLevelClusterTests.m
//  Cluster Initializer Examples
//
//  Created by Brian Nickel on 8/14/14.
//  Copyright (c) 2014 Brian Nickel. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "InitializerLevelCluster.h"

@interface InitializerLevelClusterTests : XCTestCase

@end

@implementation InitializerLevelClusterTests

- (void)testUninitializedLength
{
    @try {
        id uninitialized = [InitializerLevelCluster alloc];
        [uninitialized length];
        XCTFail(@"An exception should have been thrown.");
    }
    @catch (NSException *exception) {
        XCTAssertEqualObjects(@"length is not implemented. Did you forget to call init?", exception.reason, @"Got wrong exception.");
    }
}

- (void)testUninitializedValue
{
    @try {
        id uninitialized = [InitializerLevelCluster alloc];
        [uninitialized value];
        XCTFail(@"An exception should have been thrown.");
    }
    @catch (NSException *exception) {
        XCTAssertEqualObjects(@"value is not implemented. Did you forget to call init?", exception.reason, @"Got wrong exception.");
    }
}

- (void)testString
{
    id stringCluster = [[InitializerLevelCluster alloc] initWithString:@"test"];
    XCTAssertNotEqual([stringCluster class], [InitializerLevelCluster class], @"Should be a subclass.");
    XCTAssertTrue([stringCluster isKindOfClass:[InitializerLevelCluster class]], @"Should be a subclass.");
    XCTAssertEqualObjects(@"test", [stringCluster value], @"Incorrect value.");
    XCTAssertEqual(4, [stringCluster length], @"Incorrect length");
}

- (void)testInteger
{
    id integerCluster = [[InitializerLevelCluster alloc] initWithInteger:12345];
    XCTAssertNotEqual([integerCluster class], [InitializerLevelCluster class], @"Should be a subclass.");
    XCTAssertTrue([integerCluster isKindOfClass:[InitializerLevelCluster class]], @"Should be a subclass.");
    XCTAssertEqualObjects(@"12345", [integerCluster value], @"Incorrect value.");
    XCTAssertEqual(5, [integerCluster length], @"Incorrect length");
}

@end
