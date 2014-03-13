//
//  YAObject.m
//  ApolloLearning
//
//  Created by KONG on 10/1/14.
//  Copyright (c) 2014 Y Academy. All rights reserved.
//

#import "YAObject.h"

@implementation YAObject

+ (id)createEntity {
    return [[[self class] alloc] init];
}

- (void)saveEntity {
    
}
- (void)deleteEntity {
    
}

// Query

+ (void)findAllWithBlock:(YAArrayResultBlock)block {
    
}

+ (void)findAllSortedBy:(NSString *)sortAttr ascending:(BOOL)ascending block:(YAArrayResultBlock)block {
        
}


@end
