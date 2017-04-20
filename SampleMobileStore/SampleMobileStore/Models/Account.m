//
//  Account.m
//  SampleMobileStore
//
//  Created by Pamela Vong on 4/18/17.
//  Copyright © 2017 Listrak. All rights reserved.
//

#import "Account.h"

NSString *const AccountUserChangedNotification = @"AccountUserChangedNotification";

@implementation Account

+ (Account *)sharedInstance;
{
    static Account *myInstance = nil;
    if (myInstance == nil) {
        myInstance = [[[self class] alloc] init];
        [myInstance readUserDefaults];
    }
    return myInstance;
}

- (BOOL)isSignedIn;
{
    return self.email.length != 0;
}

- (BOOL)signInWithEmail:(NSString *)email
              firstName:(NSString *)firstName
               lastName:(NSString *)lastName;
{
    if (email.length != 0 && firstName.length != 0 && lastName != 0) {
        self.email = email;
        self.firstName = firstName;
        self.lastName = lastName;
        
        [self saveUserDefaults];
        
        // TODO: invoke SDK call to setSessionIdentity
        
        return true;
    } else {
        return false;
    }
}

- (void)signOut;
{
    self.email = nil;
    self.firstName = nil;
    self.lastName = nil;
    
    [self saveUserDefaults];
    
    // TODO: invoke SDK call to startSession
}

- (void)saveUserDefaults;
{
    [self notifyUserChanged];
    
    [[NSUserDefaults standardUserDefaults] setValue:self.email forKey:@"Email"];
    [[NSUserDefaults standardUserDefaults] setValue:self.firstName forKey:@"FirstName"];
    [[NSUserDefaults standardUserDefaults] setValue:self.lastName forKey:@"LastName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)readUserDefaults;
{
    self.email = [[NSUserDefaults standardUserDefaults] stringForKey:@"Email"];
    self.firstName = [[NSUserDefaults standardUserDefaults] stringForKey:@"FirstName"];
    self.lastName = [[NSUserDefaults standardUserDefaults] stringForKey:@"LastName"];
}


- (void)notifyUserChanged;
{
    [[NSNotificationCenter defaultCenter]
     postNotificationName:AccountUserChangedNotification
     object:self];
}

@end
