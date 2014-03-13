//
//  YAUser.h
//  ApolloLearning
//
//  Created by KONG on 8/1/14.
//  Copyright (c) 2014 Y Academy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAObject.h"

@interface YAUser : YAObject

@property (nonatomic, strong) NSString *userID;

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSURL *pictureUrl;


+ (id)userFromJson:(id)jsonObject;

@end


@protocol YAUser <NSObject, NSCoding>

+ (id)userFromJson:(id)jsonObject;

@end