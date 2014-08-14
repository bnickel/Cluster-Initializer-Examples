//
//  AllocLevelCluster.m
//  Cluster Initializer Examples
//
//  Created by Brian Nickel on 8/14/14.
//  Copyright (c) 2014 Brian Nickel. All rights reserved.
//

#import "AllocLevelCluster.h"

@interface ConcreteAllocLevelCluster : AllocLevelCluster
@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"

@implementation AllocLevelCluster
@dynamic string;

+ (id)allocWithZone:(struct _NSZone *)zone
{
    if (self != [AllocLevelCluster class]) {
        return [super allocWithZone:zone];
    } else {
        return [ConcreteAllocLevelCluster alloc];
    }
}

- (id)copyWithZone:(NSZone *)zone
{
    return [[ConcreteAllocLevelCluster alloc] initWithString:[self.string copy]];
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return [[MutableAllocLevelCluster alloc] initWithString:[self.string copy]];
}

@end

#pragma clang diagnostic pop

@implementation ConcreteAllocLevelCluster
{
    NSString *_string;
    BOOL _initialized;
}

- (instancetype)initWithString:(NSString *)string
{
    self = [super init];
    if (self) {
        if (_initialized) {
            [NSException raise:NSInternalInconsistencyException format:@"Immutable instance initialized twice."];
        }
        
        _string = [string copy];
        _initialized = YES;
    }
    return self;
}

- (NSString *)string
{
    return _string;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end

@implementation MutableAllocLevelCluster
@synthesize string=_string;

- (instancetype)initWithString:(NSString *)string
{
    self = [super init];
    if (self) {
        _string = [string copy];
    }
    return self;
}

@end