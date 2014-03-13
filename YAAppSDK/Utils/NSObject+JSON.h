//
//  NSObject+JSON.h
//  ApolloLearning
//
//  Created by KONG on 9/1/14.
//  Copyright (c) 2014 Y Academy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JSON)

- (NSString *)jsonStringWithPrettyPrint:(BOOL) prettyPrint;

+ (id)jsonFromString:(NSString *)string;
@end
