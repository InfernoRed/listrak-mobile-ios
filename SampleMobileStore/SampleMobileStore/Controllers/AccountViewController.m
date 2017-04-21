//
//  AccountViewController.m
//  SampleMobileStore
//
//  Created by Pamela Vong on 4/19/17.
//  Copyright © 2017 Listrak. All rights reserved.
//

#import "AccountViewController.h"

@interface AccountViewController ()

@end

@implementation AccountViewController

- (IBAction)signIn:(id)sender {
    BOOL success = [[Account sharedInstance] signInWithEmail:self.txtEmail.text firstName:self.txtFirstName.text lastName:self.txtLastName.text];
    
    if (!success) {
        id alert = [UIAlertController alertControllerWithTitle:@"Can't Sign In" message:@"Please fill in all fields and try again" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (IBAction)signOut:(id)sender {
    [[Account sharedInstance] signOut];
}

- (IBAction)close:(id)sender {
    [self.delegate accountViewControllerClosed:self];
}


- (void)accountUserChangedNotification {
    Account *account = [Account sharedInstance];
    BOOL isSignedIn = account.isSignedIn;
    
    self.lblDescription.text = isSignedIn ? @"The following is information about your account." : @"Enter your information below and click the Sign In.";
    self.vwSignIn.hidden = isSignedIn;
    self.vwSignOut.hidden = !isSignedIn;
    self.lblFirstName.text = account.firstName;
    self.lblLastName.text = account.lastName;
    self.lblEmail.text = account.email;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(accountUserChangedNotification)
     name:AccountUserChangedNotification
     object:nil];

    [self accountUserChangedNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
