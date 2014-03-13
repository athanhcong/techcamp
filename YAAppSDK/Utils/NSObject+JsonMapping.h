//
//  NSObject+JsonMapping.h
//  ApolloLearning
//
//  Created by KONG on 9/1/14.
//  Copyright (c) 2014 Y Academy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DCKeyValueObjectMapping/DCKeyValueObjectMapping.h>

@interface NSObject (JsonMapping)


+ (id)objectFromData:(NSData *)jsonData forClass:(Class)objClass mappingDictionary:(NSDictionary *)mappingDictionary;

+ (id)objectFromJson:(id)json forClass:(Class)objClass mappingDictionary:(NSDictionary *)mappingDictionary;


+ (DCKeyValueObjectMapping *)parserForClass:(Class)objClass mappingDictionary:(NSDictionary *)mappingDictionary;
@end
