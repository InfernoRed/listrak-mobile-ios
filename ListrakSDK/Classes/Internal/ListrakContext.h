//
//  ListrakContext.h
//  ListrakSDK
//
//  Created by Pamela Vong on 5/7/17.
//
//

#import <Foundation/Foundation.h>

@interface ListrakContext : NSObject

+ (NSString *)globalSessionId;
+ (NSString *)visitId;
+ (NSString *)templateId;
+ (NSString *)merchantId;
+ (NSString *)sessionId;
+ (NSString *)hostOverride;
+ (BOOL)useHttps;
+ (void)initTimestamp;
+ (long)unixTimestamp;
+ (NSString *)generateUid;
+ (void)validate;

@end
