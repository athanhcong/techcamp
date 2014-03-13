//
//  NSObject+Utility.h
//  BabyCastle
//
//  Created by Vo Thanh Cong on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Block)

+ (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
- (id)performSelectorSafely:(SEL)aSelector withObject:(id)object;

+ (void)performLowPriorityTask:(void (^)(void))block;
@end
