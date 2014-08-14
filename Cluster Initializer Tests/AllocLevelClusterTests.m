//
//  AllocLevelClusterTests.m
//  Cluster Initializer Examples
//
//  Created by Brian Nickel on 8/14/14.
//  Copyright (c) 2014 Brian Nickel. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AllocLevelCluster.h"

@interface AllocLevelClusterTests : XCTestCase

@end

@implementation AllocLevelClusterTests

- (void)testBase
{
    AllocLevelCluster *instance = [[AllocLevelCluster alloc] initWithString:@"hello"];
    XCTAssertNotEqual([instance class], [AllocLevelCluster class], @"Should be a subclass.");
    XCTAssertTrue([instance isKindOfClass:[AllocLevelCluster class]], @"Should be a subclass.");
    XCTAssertEqualObjects(@"hello", instance.string, @"Incorrect value.");
    XCTAssertEqual(instance, [instance copy], @"Concrete subclass should return self as copy.");
}

- (void)testSubclass
{
    MutableAllocLevelCluster *instance = [[MutableAllocLevelCluster alloc] initWithString:@"hello"];
    XCTAssertEqual([instance class], [MutableAllocLevelCluster class], @"Should be a subclass.");
    XCTAssertEqualObjects(@"hello", instance.string, @"Incorrect value.");
    XCTAssertNotEqual(instance, [instance copy], @"Should return different object.");
    XCTAssertNotEqual(instance, [instance mutableCopy], @"Should return different object.");
}

@end
