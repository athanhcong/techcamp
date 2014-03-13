//
//  TCNotification.h
//  TechCamp
//
//  Created by KONG on 13/3/14.
//  Copyright (c) 2014 TechCamp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCNotification : NSObject

@property (nonatomic, strong) NSString *notificationID, *subject, *message, *sentAt;

@property (nonatomic, strong) NSDate *createdAt;
+ (id)objectFromJson:(id)jsonObject;
@end
