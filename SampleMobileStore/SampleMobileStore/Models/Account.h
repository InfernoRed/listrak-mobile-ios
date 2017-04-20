//
//  Account.h
//  SampleMobileStore
//
//  Created by Pamela Vong on 4/18/17.
//  Copyright © 2017 Listrak. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AccountDelegate <NSObject>
@required
- (void)processUserChanged;
@end

@interface Account : NSObject

@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;


+ (Account *)sharedInstance;

- (BOOL)isSignedIn;
- (BOOL)signInWithEmail:(NSString *)email
              firstName:(NSString *)firstName
               lastName:(NSString *)lastName;
- (void)signOut;

@end
