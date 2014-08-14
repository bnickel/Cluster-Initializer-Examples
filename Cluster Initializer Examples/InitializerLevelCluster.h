//
//  InitializerLevelCluster.h
//  Cluster Initializer Examples
//
//  Created by Brian Nickel on 8/14/14.
//  Copyright (c) 2014 Brian Nickel. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 * @discussion This is similar to NSNumber where each initializer returns a unique subclass.
 */
@interface InitializerLevelCluster : NSObject
- (instancetype)initWithInteger:(NSInteger)value;
- (instancetype)initWithString:(NSString *)value;
- (NSInteger)length;
- (NSString *)value;
@end
