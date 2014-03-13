//
//  TCTalk.h
//  TechCamp
//
//  Created by KONG on 13/3/14.
//  Copyright (c) 2014 TechCamp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCTalk : NSObject


@property (nonatomic, strong) NSString *talkID, *talkDescription, *slideUrl, *speakerDescription, *speakerName, *speakerUrl, *title;
@property (nonatomic, strong) NSNumber *duration, *favCount, *voteCount;

@property (nonatomic, assign) BOOL faved, voted;

+ (id)objectFromJson:(id)json;

@end
