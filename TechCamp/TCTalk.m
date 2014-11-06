//
//  TCTalk.m
//  TechCamp
//
//  Created by KONG on 13/3/14.
//  Copyright (c) 2014 TechCamp. All rights reserved.
//

#import "TCTalk.h"
#import "NSObject+JsonMapping.h"

static NSDateFormatter *dateFormater = nil;

@implementation TCTalk

+ (NSDateFormatter *)dateFormatter {
    if (!dateFormater) {
        dateFormater = [[NSDateFormatter alloc] init];
        dateFormater.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    
    return dateFormater;
}


+ (id)objectFromJson:(id)jsonObject {
    TCTalk *object = [NSObject objectFromJson:jsonObject forClass:[self class] mappingDictionary:@{@"description": @"talkDescription", @"created_at": @"createdAtString"}];
    
//    object.time = @"10:00 - 11:00";
//    object.location = @"room 20";
    
    if (object.createdAtString.length >= 19) {
        object.createdAt = [[self dateFormatter] dateFromString:
                                  [object.createdAtString substringToIndex:19]];
    }
    

    return object;
}

@end
