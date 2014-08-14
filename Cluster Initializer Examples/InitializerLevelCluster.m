//
//  InitializerLevelCluster.m
//  Cluster Initializer Examples
//
//  Created by Brian Nickel on 8/14/14.
//  Copyright (c) 2014 Brian Nickel. All rights reserved.
//

#import "InitializerLevelCluster.h"

@interface PlaceholderInitializerLevelCluster : InitializerLevelCluster
@end

@interface _StringInitializerLevelCluster : InitializerLevelCluster
@property (nonatomic, copy, readonly) NSString *value;
@end

@interface _IntegerInitializerLevelCluster : InitializerLevelCluster
@property (nonatomic, assign, readonly) NSInteger integerValue;
@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"

@implementation InitializerLevelCluster

+ (id)allocWithZone:(struct _NSZone *)zone
{
    // If we are a subclass, use the normal allocator.  Otherwise we return a placeholder subclass which instantiates a different child on init.  We could have done everything in once class but the placeholder allows us to separate out factory logic from the base class.
    
    if (self != [InitializerLevelCluster class]) {
        return [super allocWithZone:zone];
    }
    
    // The placeholder is immutable and the init methods will return new instances, so we can avoid duplicate allocation costs with a singleton.
    static PlaceholderInitializerLevelCluster *placeholder;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        placeholder = [PlaceholderInitializerLevelCluster alloc];
    });
    return placeholder; // Because of implicit __attribute__((ns_returns_retained)), placholder gets retained.
}

@end

#pragma clang diagnostic pop

@implementation PlaceholderInitializerLevelCluster

- (id)init
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (id)initWithString:(NSString *)value
{
    // Because of implicit __attribute__((ns_consumes_self)), instance of PlaceholderInitializerLevelCluster will be released.
    return (id)[[_StringInitializerLevelCluster alloc] initWithString:value];
}

- (id)initWithInteger:(NSInteger)value
{
    // Because of implicit __attribute__((ns_consumes_self)), instance of PlaceholderInitializerLevelCluster will be released.
    return (id)[[_IntegerInitializerLevelCluster alloc] initWithInteger:value];
}

- (void)doesNotRecognizeSelector:(SEL)aSelector
{
    [NSException raise:NSInternalInconsistencyException format:@"%@ is not implemented. Did you forget to call init?", NSStringFromSelector(aSelector)];
}

@end

@implementation _StringInitializerLevelCluster

- (instancetype)initWithString:(NSString *)value
{
    self = [super init];
    if (self) {
        _value = value;
    }
    return self;
}

- (NSInteger)length
{
    return self.value.length;
}

@end

@implementation _IntegerInitializerLevelCluster

- (instancetype)initWithInteger:(NSInteger)value
{
    self = [super init];
    if (self) {
        _integerValue = value;
    }
    
    return self;
}

- (NSString *)value
{
    return [NSString stringWithFormat:@"%ld", (long)self.integerValue];
}

- (NSInteger)length
{
    NSInteger value = self.integerValue / 10;
    NSInteger length = 1;
    
    while (value > 0) {
        length ++;
        value /= 10;
    }
    
    return length;
}

@end
