//
//  AccountViewController.h
//  SampleMobileStore
//
//  Created by Pamela Vong on 4/19/17.
//  Copyright © 2017 Listrak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Account.h"

@class AccountViewController;

@protocol AccountViewControllerDelegate <NSObject>
@required
- (void)accountViewControllerClosed:(AccountViewController *)controller;
@end

@interface AccountViewController : UIViewController

@property (nonatomic, weak) id <AccountViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *lblDescription;
@property (strong, nonatomic) IBOutlet UIView *vwSignIn;
@property (strong, nonatomic) IBOutlet UITextField *txtFirstName;
@property (strong, nonatomic) IBOutlet UITextField *txtLastName;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UIView *vwSignOut;
@property (strong, nonatomic) IBOutlet UILabel *lblFirstName;
@property (strong, nonatomic) IBOutlet UILabel *lblLastName;
@property (strong, nonatomic) IBOutlet UILabel *lblEmail;
@property (strong, nonatomic) IBOutlet UISwitch *swSubscribe;

- (IBAction)signIn:(id)sender;
- (IBAction)signOut:(id)sender;
- (IBAction)close:(id)sender;

@end
