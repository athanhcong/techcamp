//
//  ALFakeAPIServer.h
//  ApolloLearning
//
//  Created by KONG on 5/1/14.
//  Copyright (c) 2014 Y Academy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ILCannedURLProtocol.h"

@interface YAFakeAPIServer : NSObject <ILCannedURLProtocolDelegate>

+ (id)server;
+ (void)registerFakeServerWithHost:(NSString *)host;
+ (void)unregisterFakeServer;


@end
