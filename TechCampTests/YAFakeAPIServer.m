//
//  ALFakeAPIServer.m
//  ApolloLearning
//
//  Created by KONG on 5/1/14.
//  Copyright (c) 2014 Y Academy. All rights reserved.
//

#import "YAFakeAPIServer.h"
#import "ILCannedURLProtocol.h"

@implementation YAFakeAPIServer


static NSString *apiHost = nil;

+ (id)server {
    // Singleton, link: http://stackoverflow.com/a/7569010/192800
    
    static YAFakeAPIServer *server;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        server = [[YAFakeAPIServer alloc] init];
    });
    return server;
}


+ (void)registerFakeServerWithHost:(NSString *)host {
    //register as Protocol delegate, the magic begins
    [NSURLProtocol registerClass:[ILCannedURLProtocol class]];
    
    apiHost = host;
    
    [ILCannedURLProtocol setDelegate:[YAFakeAPIServer server]];
    
    // Default HTTP status code
    [ILCannedURLProtocol setCannedStatusCode:200];
    
    // Configure ILtesting only for certain verbs if you like
    [ILCannedURLProtocol setSupportedMethods:[[NSArray alloc] initWithObjects:@"GET",@"POST", @"PUT", nil]];
    
    // Default headers. Ill be returning JSON here.
    NSMutableDictionary *headers = [[NSMutableDictionary alloc] init];
    [headers setObject:@"application/json; charset=utf-8" forKey:@"Content-Type"];
    [ILCannedURLProtocol setCannedHeaders: headers];
}

+ (void)unregisterFakeServer {
    [NSURLProtocol unregisterClass:[ILCannedURLProtocol class]];
}


- (NSData *)dataForJsonFilename:(NSString *)filename {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *resource = [bundle pathForResource:filename ofType:@"json"];
    
    NSData *responseData = [[NSData alloc] initWithContentsOfFile:resource];
    return responseData;
}


- (BOOL)shouldInitWithRequest:(NSURLRequest*)request {
    if (apiHost && [request.URL.host isEqualToString:apiHost] == NO) {
        return NO;
    }
    return YES;
}

- (NSData*)responseDataForClient:(id<NSURLProtocolClient>)client request:(NSURLRequest*)request {
    
    NSData *responseData = nil;

    if ([request.URL.absoluteString isEqual:@"http://example.com/testStartLoadingWithDelegate"]) {
        id requestObject = [NSDictionary dictionaryWithObjectsAndKeys:@"testStartLoadingWithDelegate", @"testName", nil];
        responseData = [NSJSONSerialization dataWithJSONObject:requestObject options:0 error:nil];
        
    }
    
    // Profile information
    if ([request.URL.path hasPrefix:@"/voting/topic/api"] &&
        [request.HTTPMethod isEqualToString:@"GET"]) {
        responseData = [self dataForJsonFilename:@"talks"];
    }
    

    // login information
    if ([request.URL.path isEqual:@"/login/facebook"] &&
        [request.HTTPMethod isEqualToString:@"POST"]) {
        responseData = [self dataForJsonFilename:@"login__facebook"];
    }
    
    

    if ([request.URL.path hasPrefix:@"/courses/"] &&
        [request.HTTPMethod isEqualToString:@"GET"]) {
        // courses_ID
        responseData = [self dataForJsonFilename:@"courses__ID"];
        
    } else if ([request.URL.path hasPrefix:@"/courses"] &&
        // courses
        [request.HTTPMethod isEqualToString:@"GET"]) {
        responseData = [self dataForJsonFilename:@"courses"];
    }
    
    // friends
    if ([request.URL.path hasPrefix:@"/users/"] &&
        [request.URL.path hasSuffix:@"/friends"] &&
        [request.HTTPMethod isEqualToString:@"GET"]) {
        responseData = [self dataForJsonFilename:@"users__ID__friends"];
    }
    
    return responseData;
}



@end
