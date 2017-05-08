//
//  ListrakContext.m
//  Pods
//
//  Created by Pamela Vong on 5/7/17.
//
//

#import "ListrakContext.h"
#import "ListrakConfig.h"
#import "ListrakSession.h"
#import "ListrakConfigExtension.h"
#import "ListrakSessionExtension.h"

static NSDate *timestamp;

@implementation ListrakContext

+ (NSString *)globalSessionId {
    return ListrakConfig.appId;
}

+ (NSString *)visitId {
    return ListrakConfig.visitId;
}

+ (NSString *)templateId {
    return ListrakConfig.clientTemplateId;
}

+ (NSString *)merchantId {
    return ListrakConfig .clientMerchantId;
}

+ (NSString *)sessionId {
    return ListrakSession.sessionId;
}

+ (NSString *)hostOverride {
    return ListrakConfig.hostOverride;
}

+ (BOOL)useHttps {
    return ListrakConfig.useHttps;
}

+ (void)initTimestamp {
    timestamp = [NSDate date];
}

+ (long)unixTimestamp {
    return (long)[timestamp timeIntervalSince1970];
}

+ (NSString *)generateUid {
    return [[NSUUID UUID] UUIDString];
}

+ (void)validate {
    [ListrakSession ensureStarted];
}

@end
