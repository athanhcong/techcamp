
#import <Foundation/Foundation.h>

@class YAObject;
@class YAUser;

// Server
extern NSString *const kYAParseServer;

typedef void (^YABooleanResultBlock)(BOOL succeeded, NSError *error);
typedef void (^YAIntegerResultBlock)(int number, NSError *error);
typedef void (^YAArrayResultBlock)(NSArray *objects, NSError *error);
typedef void (^YASetResultBlock)(NSSet *channels, NSError *error);
typedef void (^YAUserResultBlock)(YAUser *user, NSError *error);
typedef void (^YADataResultBlock)(NSData *data, NSError *error);
typedef void (^YADataStreamResultBlock)(NSInputStream *stream, NSError *error);
typedef void (^YAStringResultBlock)(NSString *string, NSError *error);
typedef void (^YAIdResultBlock)(id object, NSError *error);
typedef void (^YAProgressBlock)(int percentDone);

//typedef void (^YAProgressBlock)(int percentDone);



#pragma mark Convenience Define

#define NSNTFC [NSNotificationCenter defaultCenter]
#define NSNTFo(observer, sel, event) [[NSNotificationCenter defaultCenter] addObserver:observer selector:sel name:event object:nil];

#define NSNTFp(name, sender, info) [[NSNotificationCenter defaultCenter] postNotificationName:name object:sender userInfo:info];

#define NSDEF [NSUserDefaults standardUserDefaults]

typedef void (^ObjectResultBlock)(id object, NSError *error);


#ifdef DEBUG
#       define LLog() printf(("%s (line %d)\n"), __PRETTY_FUNCTION__, __LINE__)
#       define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#       define DLogObj(f) DLog(@"%@", f)

#       define RLog(f) DLog(@"%@", NSStringFromCGRect(f))
#else
#       define DLog(...)
#       define LLog()
#       define RLog(f)
#       define DLogObj(f)

#endif


#define kInstallationDeviceToken @"kInstallationDeviceToken"


#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define IS_OS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define IS_OS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)