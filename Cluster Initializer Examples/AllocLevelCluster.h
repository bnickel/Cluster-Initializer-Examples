//
//  AllocLevelCluster.h
//  Cluster Initializer Examples
//
//  Created by Brian Nickel on 8/14/14.
//  Copyright (c) 2014 Brian Nickel. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 * @discussion This is similar to NSString where the base class returns an immutable subclass but subclasses return themselves.
 */
@interface AllocLevelCluster : NSObject<NSCopying, NSMutableCopying>
- (instancetype)initWithString:(NSString *)string;
@property (nonatomic, copy, readonly) NSString *string;
@end

@interface MutableAllocLevelCluster : AllocLevelCluster
@property (nonatomic, copy, readwrite) NSString *string;
@end