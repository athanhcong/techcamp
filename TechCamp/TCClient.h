//
//  TCClient.h
//  TechCamp
//
//  Created by KONG on 13/3/14.
//  Copyright (c) 2014 TechCamp. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YAClient.h"

@interface TCClient : YAClient



- (id)cachedTalks;
- (void)getTalksWithBlock:(YAArrayResultBlock)block;



- (void)voteWithTopicID:(NSString *)topicID block:(YAIdResultBlock)block;
- (void)favoriteWithTopicID:(NSString *)topicID block:(YAIdResultBlock)block;



- (void)registerPushWithDeviceToken:(NSString *)deviceToken block:(YAIdResultBlock)block;

- (id)cachedNotifications;
- (void)getNotificationsWithBlock:(YAArrayResultBlock)block;


@end
