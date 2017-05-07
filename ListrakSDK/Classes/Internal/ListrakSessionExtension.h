//
//  ListrakSessionExtension.h
//  Pods
//
//  Created by Pamela Vong on 5/7/17.
//
//

#import <Foundation/Foundation.h>

@interface ListrakSession () {
    BOOL _isStarted;
    BOOL _hasIdentity;
    NSString *_sessionId;
    NSString *_emailAddress;
    NSString *_firstName;
    NSString *_lastName;
}

- (BOOL)isStarted;
- (BOOL)hasIdentity;
- (NSString *)sessionId;
- (NSString *)emailAddress;
- (NSString *)firstName;
- (NSString *)lastName;

+ (void)ensureStarted;
+ (void)reset;

@end

