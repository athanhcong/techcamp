//
//  TCNotification.m
//  TechCamp
//
//  Created by KONG on 13/3/14.
//  Copyright (c) 2014 TechCamp. All rights reserved.
//

#import "TCNotification.h"
#import "NSObject+JsonMapping.h"
//#import <FormatterKit/TTT

static NSDateFormatter *dateFormater = nil;

@implementation TCNotification


+ (NSDateFormatter *)dateFormatter {
    if (!dateFormater) {
        dateFormater = [[NSDateFormatter alloc] init];
        dateFormater.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    
    return dateFormater;
}

+ (id)objectFromJson:(id)jsonObject {
    TCNotification *notification = [NSObject objectFromJson:jsonObject forClass:[self class] mappingDictionary:@{@"id": @"notificationID"}];
    
    
    
    if (notification.sentAt.length >= 19) {
        notification.createdAt = [[self dateFormatter] dateFromString:
                                  [notification.sentAt substringToIndex:19]];
    }

    
    
    
    
    return notification;
}

@end
