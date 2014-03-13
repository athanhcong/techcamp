//
//  NSObject+Utility.m
//  BabyCastle
//
//  Created by Vo Thanh Cong on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSObject+Block.h"

@implementation NSObject (Block)

// http://forrst.com/posts/Delayed_Blocks_in_Objective_C-0Fn
+ (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay  {
    int64_t delta = (int64_t)(1.0e9 * delay);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delta), dispatch_get_main_queue(), block);
}

- (id)performSelectorSafely:(SEL)aSelector withObject:(id)object {
    if ([self respondsToSelector:aSelector]) {
        // Remove a warning: http://stackoverflow.com/a/7933931/192800
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return [self performSelector:aSelector withObject:object];
    }
    return nil;
}

+ (void)performLowPriorityTask:(void (^)(void))block {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0), ^{
        dispatch_async(dispatch_get_main_queue(), block);
    });
}

@end
