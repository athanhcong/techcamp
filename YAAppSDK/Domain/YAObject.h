//
//  YAObject.h
//  ApolloLearning
//
//  Created by KONG on 10/1/14.
//  Copyright (c) 2014 Y Academy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YAObject : NSObject

+ (id)createEntity;

- (void)saveEntity;
- (void)deleteEntity;

// Query

+ (void)findAllWithBlock:(YAArrayResultBlock)block;
+ (void)findAllSortedBy:(NSString *)sortAttr ascending:(BOOL)ascending block:(YAArrayResultBlock)block;

@end
