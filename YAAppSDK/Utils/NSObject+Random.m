//
//  NSObject+Random.m
//  ApolloLearning
//
//  Created by KONG on 19/1/14.
//  Copyright (c) 2014 Y Academy. All rights reserved.
//

#import "NSObject+Random.h"

@implementation NSObject (Random)

+ (NSArray*)shuffleArray:(NSArray*)array limitedElement:(NSInteger)elementCount {
    if (elementCount > [array count]) {
        return nil;
    }
    
    NSMutableArray *temp = [[NSMutableArray alloc] initWithArray:array];
    
    NSInteger randomLimit = [array count] - elementCount + 1;
    
    for(NSUInteger i = [array count]; i >= randomLimit & i >=1; i--) {
        NSUInteger j = arc4random_uniform(i);
        [temp exchangeObjectAtIndex:i-1 withObjectAtIndex:j];
    }
    
    return [temp subarrayWithRange:NSMakeRange(randomLimit -  1, elementCount)];
}

+ (NSArray*)shuffleArray:(NSArray*)array {
    return [self shuffleArray:array limitedElement:[array count]];
}

+ (NSInteger)aRandomNumber:(NSUInteger)upperLimit {
    return arc4random_uniform(upperLimit);
}

@end
