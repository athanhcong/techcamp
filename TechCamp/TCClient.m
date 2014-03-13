//
//  TCClient.m
//  TechCamp
//
//  Created by KONG on 13/3/14.
//  Copyright (c) 2014 TechCamp. All rights reserved.
//

#import "TCClient.h"
#import <TMCache/TMCache.h>
#import "TCTalk.h"



@implementation TCClient

-(NSString*)uniqueIDForDevice
{
    NSString* uniqueIdentifier = nil;
    if( [UIDevice instancesRespondToSelector:@selector(identifierForVendor)] ) { // >=iOS 7
        uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    } else { //<=iOS6, Use UDID of Device
        CFUUIDRef uuid = CFUUIDCreate(NULL);
        //uniqueIdentifier = ( NSString*)CFUUIDCreateString(NULL, uuid);- for non- ARC
        uniqueIdentifier = (NSString *)CFBridgingRelease(CFUUIDCreateString(NULL, uuid));// for ARC
        CFRelease(uuid);
    }
    return uniqueIdentifier;
}

- (NSString *)deviceId {
    return [self uniqueIDForDevice];
}


- (NSArray *)talksFromJson:(id)json {
    
    NSMutableArray *talks = [NSMutableArray array];
    for (NSString *talkID in json) {
        NSDictionary *talkJson = [json objectForKey:talkID];
        
        TCTalk *talk = [TCTalk objectFromJson:talkJson];
        
        talk.talkID = talkID;
        [talks addObject:talk];
    }
    
    
    return talks;
}

- (id)cachedTalks {
    NSString *urlPath = [NSString stringWithFormat:@"/voting/topic/api?device_id=%@", [self deviceId]];
    
    id json = [[TMCache sharedCache] objectForKey:urlPath];
    NSArray *talks = [self talksFromJson:json];

    return talks;
}

- (void)getTalksWithBlock:(YAArrayResultBlock)block {
    NSString *urlPath = [NSString stringWithFormat:@"/voting/topic/api?device_id=%@", [self deviceId]];
    
    [self getJsonWithPath:urlPath params:nil block:^(id object, NSError *error) {

        NSArray *talks = nil;
        if (object && !error) {
            [[TMCache sharedCache] setObject:object forKey:urlPath];
            talks = [self talksFromJson:object];
        }
        
        block(talks, error);
    }];
}


- (void)voteWithTopicID:(NSString *)topicID block:(YAIdResultBlock)block {
    
    if (!topicID) {
        return;
    }
    
    NSString *urlPath = [NSString stringWithFormat:@"/voting/topic/vote"];
    
    NSDictionary *params = @{@"id": [self deviceId], @"topic_id": topicID};
    
    [self postJsonWithPath:urlPath params:params block:^(id object, NSError *error) {
        DLogObj(error);
        DLogObj(object);
        
        if (error == nil && object != nil ) {
            
        }
        
        if (block) block(object, error);
    }];

}

- (void)favoriteWithTopicID:(NSString *)topicID block:(YAIdResultBlock)block {
    if (!topicID) {
        return;
    }
    
    NSString *urlPath = [NSString stringWithFormat:@"/voting/topic/fav"];
    
    NSDictionary *params = @{@"id": [self deviceId], @"topic_id": topicID};
    
    [self postJsonWithPath:urlPath params:params block:^(id object, NSError *error) {
        DLogObj(error);
        DLogObj(object);
        
        if (error == nil && object != nil ) {
            
        }
        
        if (block) block(object, error);
    }];

}


- (void)registerPushWithDeviceToken:(NSString *)deviceToken block:(YAIdResultBlock)block {
    
}

- (id)cachedNotifications {
    NSString *urlPath = [NSString stringWithFormat:@"/voting/topic/api?device_id=%@", [self deviceId]];
    
    id json = [[TMCache sharedCache] objectForKey:urlPath];
    NSArray *talks = [self talksFromJson:json];
    
    return talks;
}

- (void)getNotificationsWithBlock:(YAArrayResultBlock)block {
    NSString *urlPath = [NSString stringWithFormat:@"/voting/topic/api?device_id=%@", [self deviceId]];
    
    [self getJsonWithPath:urlPath params:nil block:^(id object, NSError *error) {
        
        NSArray *talks = nil;
        if (object && !error) {
            [[TMCache sharedCache] setObject:object forKey:urlPath];
            talks = [self talksFromJson:object];
        }
        
        block(talks, error);
    }];
}

@end
