//
//  YAClient.h
//  ApolloLearning
//
//  Created by KONG on 8/1/14.
//  Copyright (c) 2014 Y Academy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YAConstants.h"
#import "YAUser.h"
#import "YAObject.h"


#define SERVER_API @"http://techcamp.vn"
#define SERVER_API_HOST @"techcamp.vn"

@interface YAClient : NSObject

@property(nonatomic, copy) NSString *apiHost;


+ (id)defaultClient;

- (void)loginWithFacebookToken:(NSString *)fbToken block:(YAUserResultBlock)block;

+ (BOOL)isAuthenticated;
+ (NSString *)authenticatedUserID;
+ (NSString *)accessToken;
- (void)storeAuthenticatedUserID:(NSString *)userID andAccessToken:(NSString *)accessToken;

+ (void)logout;


/* Request */

- (void)getJsonWithPath:(NSString *)apiPath params:(NSDictionary *)dictionary block:(YAIdResultBlock)block;

- (void)postJsonWithPath:(NSString *)apiPath params:(NSDictionary *)params block:(YAIdResultBlock)block;
@end
