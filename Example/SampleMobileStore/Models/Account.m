//
//  Account.m
//  SampleMobileStore
//
//  Created by Pamela Vong on 4/18/17.
//  Copyright © 2017 Listrak. All rights reserved.
//

#import <ListrakSDK/ListrakSession.h>
#import "Account.h"

NSString *const AccountUserChangedNotification = @"AccountUserChangedNotification";

@implementation Account

+ (Account *)sharedInstance {
    static Account *myInstance = nil;
    if (myInstance == nil) {
        myInstance = [[[self class] alloc] init];
        [myInstance readUserDefaults];
    }
    return myInstance;
}

- (BOOL)isSignedIn {
    return self.email.length != 0;
}

- (BOOL)signInWithEmail:(NSString *)email
              firstName:(NSString *)firstName
               lastName:(NSString *)lastName
              subscribe:(BOOL)subscribe {
    if (email.length != 0 && firstName.length != 0 && lastName.length != 0) {
        self.email = email;
        self.firstName = firstName;
        self.lastName = lastName;
        
        [self saveUserDefaults];
        
        // LISTRAK SDK
        // when a user signs-in set the session identity
        // (a session should have been started when app started)
        //
        [ListrakSession setIdentityWithEmailAddress:email
                                          firstName:firstName
                                           lastName:lastName];

        if (subscribe) {
            // LISTRAK SDK
            // a user can be subscribe to a Listrak mailing list
            // This can be done anytime after a session has been identified
            //
            [ListrakSession subscribeWithSubscriberCode:@"SAMPLEAPP"
                                                   meta:@{@"fname":firstName, @"lname":lastName}];
        }
        
        return YES;
    } else {
        return NO;
    }
}

- (void)signOut {
    self.email = nil;
    self.firstName = nil;
    self.lastName = nil;
    
    [self saveUserDefaults];
    
    // LISTRAK SDK
    // always need a session
    // when user signs-out start a new session
    //
    [ListrakSession start];
}

- (void)saveUserDefaults {
    [self notifyUserChanged];
    
    [[NSUserDefaults standardUserDefaults] setValue:self.email forKey:@"Email"];
    [[NSUserDefaults standardUserDefaults] setValue:self.firstName forKey:@"FirstName"];
    [[NSUserDefaults standardUserDefaults] setValue:self.lastName forKey:@"LastName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)readUserDefaults {
    self.email = [[NSUserDefaults standardUserDefaults] stringForKey:@"Email"];
    self.firstName = [[NSUserDefaults standardUserDefaults] stringForKey:@"FirstName"];
    self.lastName = [[NSUserDefaults standardUserDefaults] stringForKey:@"LastName"];
}


- (void)notifyUserChanged {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:AccountUserChangedNotification
     object:self];
}

@end
