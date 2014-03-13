//
//  NSObject+Random.h
//  ApolloLearning
//
//  Created by KONG on 19/1/14.
//  Copyright (c) 2014 Y Academy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Random)

+ (NSArray*)shuffleArray:(NSArray*)array;
+ (NSArray*)shuffleArray:(NSArray*)array limitedElement:(NSInteger)elementCount;


+ (NSInteger)aRandomNumber:(NSUInteger)upperLimit;
@end
