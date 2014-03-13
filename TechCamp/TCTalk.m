//
//  TCTalk.m
//  TechCamp
//
//  Created by KONG on 13/3/14.
//  Copyright (c) 2014 TechCamp. All rights reserved.
//

#import "TCTalk.h"
#import "NSObject+JsonMapping.h"

@implementation TCTalk

+ (id)objectFromJson:(id)jsonObject {
    TCTalk *object = [NSObject objectFromJson:jsonObject forClass:[self class] mappingDictionary:@{@"description": @"talkDescription"}];
    
//    object.time = @"10:00 - 11:00";
//    object.location = @"room 20";
    return object;
}

@end
