//
//  NSObject+JsonMapping.m
//  ApolloLearning
//
//  Created by KONG on 9/1/14.
//  Copyright (c) 2014 Y Academy. All rights reserved.
//

#import "NSObject+JsonMapping.h"

#import <DCKeyValueObjectMapping/DCKeyValueObjectMapping.h>
#import <DCKeyValueObjectMapping/DCParserConfiguration.h>
#import <DCKeyValueObjectMapping/DCObjectMapping.h>



@implementation NSObject (JsonMapping)



+ (DCKeyValueObjectMapping *)parserForClass:(Class)objClass mappingDictionary:(NSDictionary *)mappingDictionary {
    
    DCParserConfiguration *config = [DCParserConfiguration configuration];
    
    for (NSString *keyPath in mappingDictionary) {
        NSString *attribute = [mappingDictionary objectForKey:keyPath];
        DCObjectMapping *idToUserId = [DCObjectMapping mapKeyPath:keyPath toAttribute:attribute onClass:objClass];
        [config addObjectMapping:idToUserId];
    }
    
    DCKeyValueObjectMapping *parser = [DCKeyValueObjectMapping mapperForClass:objClass  andConfiguration:config];
    
    return parser;
}

+ (id)objectFromData:(NSData *)jsonData forClass:(Class)objClass mappingDictionary:(NSDictionary *)mappingDictionary {
    
    NSError *error;
    NSDictionary *jsonParsed = [NSJSONSerialization JSONObjectWithData:jsonData
                                                               options:NSJSONReadingMutableContainers error:&error];

    return [self objectFromJson:jsonParsed forClass:objClass mappingDictionary:mappingDictionary];

}

+ (id)objectFromJson:(id)json forClass:(Class)objClass mappingDictionary:(NSDictionary *)mappingDictionary {
    DCKeyValueObjectMapping *parser = [self parserForClass:objClass
                                         mappingDictionary:mappingDictionary];
    
    return [parser parseDictionary:json];
}

@end
