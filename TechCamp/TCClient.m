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



- (NSString *)deviceId {
    return @"21343";
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
    NSString *urlPath = [NSString stringWithFormat:@"/voting/topic/api?device_id=1234"];
    
    id json = [[TMCache sharedCache] objectForKey:urlPath];
    NSArray *talks = [self talksFromJson:json];

    return talks;
}

- (void)getTalksWithBlock:(YAArrayResultBlock)block {
    NSString *urlPath = [NSString stringWithFormat:@"/voting/topic/api?device_id=1234"];
    
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
