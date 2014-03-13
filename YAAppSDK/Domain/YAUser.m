//
//  YAUser.m
//  ApolloLearning
//
//  Created by KONG on 8/1/14.
//  Copyright (c) 2014 Y Academy. All rights reserved.
//

#import "YAUser.h"
#import "NSObject+JsonMapping.h"

@implementation YAUser

+ (id)userFromJson:(id)jsonObject {
    YAUser *userParsed = [NSObject objectFromJson:jsonObject forClass:[self class] mappingDictionary:@{@"id": @"userID"}];
    return userParsed;
}

@end
