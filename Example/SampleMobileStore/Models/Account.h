//
//  Account.h
//  SampleMobileStore
//
//  Created by Pamela Vong on 4/18/17.
//  Copyright © 2017 Listrak. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const AccountUserChangedNotification;

@interface Account : NSObject

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;


+ (Account *)sharedInstance;

- (BOOL)isSignedIn;
- (BOOL)signInWithEmail:(NSString *)email
              firstName:(NSString *)firstName
               lastName:(NSString *)lastName
              subscribe:(BOOL)subscribe;
- (void)signOut;

@end
