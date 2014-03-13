//
//  YAClient.m
//  ApolloLearning
//
//  Created by KONG on 8/1/14.
//  Copyright (c) 2014 Y Academy. All rights reserved.
//

#import "YAClient.h"
#import <AFNetworking/AFNetworking.h>
#import "YAUser.h"
#import "NSObject+JSON.h"



#define LOGIN_FACEBOOK_PATH @"/login/facebook"

@implementation YAClient

+ (id)defaultClient {
    
    static YAClient *client;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[[self class] alloc] init];
    });
    return client;
}

- (id)init {
    self = [super init];
    if (self) {
        self.apiHost = SERVER_API;
    }
    return self;
}

#pragma mark Login


static NSString *YAUserAccessTokenKey = @"YAUserAccessTokenKey";
static NSString *YAUserIDKey = @"YAUserIDKey";

- (void)loginWithFacebookToken:(NSString *)fbToken block:(YAUserResultBlock)block {
    
    // TODO: check if token is null
    // Bug, facebook is setup
    
    NSString *urlString = [SERVER_API stringByAppendingString:LOGIN_FACEBOOK_PATH];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *authenticationString = [@{@"access_token": fbToken} jsonStringWithPrettyPrint:NO];
    DLogObj(authenticationString);
    
    NSDictionary *parameters = @{@"authentication": authenticationString};
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Save accessToken
        DLogObj(responseObject);
        
        block(responseObject, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        block(nil, error);
    }];
}

+ (BOOL)isAuthenticated {
    return ([self authenticatedUserID] != 0);
}

+ (NSString *)authenticatedUserID {
    return [NSDEF objectForKey:YAUserIDKey];
}

+ (NSString *)accessToken {
    return [NSDEF objectForKey:YAUserAccessTokenKey];
}


- (void)storeAuthenticatedUserID:(NSString *)userID andAccessToken:(NSString *)accessToken {
    [NSDEF setObject:accessToken forKey:YAUserAccessTokenKey];
    
    [NSDEF setObject:userID forKey:YAUserIDKey];
    
    [NSDEF synchronize];

}


+ (void)logout {
    [NSDEF removeObjectForKey:YAUserAccessTokenKey];
    [NSDEF removeObjectForKey:YAUserIDKey];
    [NSDEF synchronize];
}

- (void)getJsonWithPath:(NSString *)apiPath params:(NSDictionary *)params block:(YAIdResultBlock)block {
    NSString *urlString = [SERVER_API stringByAppendingString:apiPath];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
//    NSString *authenticationString = [@{@"access_token": fbToken} jsonStringWithPrettyPrint:NO];

    DLogObj(urlString);
    [manager GET:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        DLogObj(responseObject);
        block(responseObject, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        block(nil, error);
    }];
}


- (void)postJsonWithPath:(NSString *)apiPath params:(NSDictionary *)params block:(YAIdResultBlock)block {
    NSString *urlString = [SERVER_API stringByAppendingString:apiPath];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //    NSString *authenticationString = [@{@"access_token": fbToken} jsonStringWithPrettyPrint:NO];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    DLogObj(urlString);
    [manager POST:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLogObj(responseObject);
        block(responseObject, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        block(nil, error);
    }];
}



@end
