//
//  ALPushNotificationService.m
//  ApolloLearning
//
//  Created by KONG on 6/3/14.
//  Copyright (c) 2014 Y Academy. All rights reserved.
//

#import "YAPushNotificationService.h"
#import "NSObject+JSON.h"

@implementation YAPushNotificationService

+ (id)sharedService {
    
    static YAPushNotificationService *service;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[[self class] alloc] init];
    });
    return service;
}

- (id)init {
    self = [super init];
    
    if (self) {
        NSNTFo(self, @selector(userDidLogin:), kAuthenticationLoggedIn);
        NSNTFo(self, @selector(userDidLogout:), kAuthenticationLoggedOut);
    }
    return self;
}

- (void)userDidLogin:(NSNotification *)notification {
    [self setupNotification];
}

- (void)userDidLogout:(NSNotification *)notification {
    [self removePushNotification];
}

#pragma mark Registering

- (void)setupNotification {
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
}

- (void)removePushNotification {
    
    NSString *deviceToken = [NSDEF objectForKey:kInstallationDeviceToken];
    
    if (deviceToken == nil) {
        return;
    }
    
    [[ALClient defaultClient] postInstallationWithDeviceToken:deviceToken userID:nil block:^(id object, NSError *error) {
        
        if (error == nil && object) {
            DLog(@"finished remove device token for user");
            [NSDEF removeObjectForKey:kInstallationDeviceToken];
            [NSDEF synchronize];
        }
    }];
}


#pragma mark UIApplication Delegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    application.applicationIconBadgeNumber = 0;
    if(launchOptions!=nil){
//        NSString *msg = [NSString stringWithFormat:@"%@", launchOptions];
//        NSLog(@"%@",msg);
        [self createAlert:launchOptions];
    }
    
    if ([ALClient isAuthenticated] && ![NSDEF objectForKey:kInstallationDeviceToken]) {
        [self setupNotification];
    } else if (![ALClient isAuthenticated] && [NSDEF objectForKey:kInstallationDeviceToken]) {
        [self removePushNotification];
    }
    return YES;
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceTokenData {
    
    NSString *deviceToken = [[deviceTokenData description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    deviceToken = [deviceToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSLog(@"deviceToken: %@", deviceToken);
    
    if ([ALClient isAuthenticated]) {
        [[ALClient defaultClient] postInstallationWithDeviceToken:deviceToken userID:[ALClient authenticatedUserID] block:^(id object, NSError *error) {
            
            if (error == nil && object) {
                DLog(@"finished registering device token");
                [NSDEF setObject:deviceToken forKey:kInstallationDeviceToken];
                [NSDEF synchronize];
            }
            
        }];
        
    }
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error {
	NSLog(@"Failed to register with error : %@", error);    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    application.applicationIconBadgeNumber = 0;
//    NSString *msg = [NSString stringWithFormat:@"%@", userInfo];
//    NSLog(@"%@",msg);
    [self createAlert:userInfo];
}


#pragma mark Handle Notification


- (void)createAlert:(NSDictionary *)userInfo {
    
    NSDictionary *data = [userInfo objectForKey:@"aps"];
    
    NSString *alert = [data objectForKey:@"alert"];
    
    if (alert) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Apo" message:[NSString stringWithFormat:@"%@", alert] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    
}


@end
