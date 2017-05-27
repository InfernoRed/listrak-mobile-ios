//
//  ListrakSession.h
//  ListrakSDK
//
//  Created by Pamela Vong on 5/6/17.
//
//

#import <Foundation/Foundation.h>

@interface ListrakSession : NSObject

+ (BOOL)isStarted;
+ (BOOL)hasIdentity;
+ (NSString *)sessionId;
+ (NSString *)emailAddress;
+ (NSString *)firstName;
+ (NSString *)lastName;

+ (void)start;
+ (void)startWithIdentityWithEmailAddress:(NSString *)email
                                firstName:(NSString *)firstName
                                 lastName:(NSString *)lastName;
+ (void)setIdentityWithEmailAddress:(NSString *)email
                          firstName:(NSString *)firstName
                           lastName:(NSString *)lastName;
+ (void)subscribeWithSubscriberCode:(NSString *)code
                               meta:(NSDictionary *)meta;

@end
