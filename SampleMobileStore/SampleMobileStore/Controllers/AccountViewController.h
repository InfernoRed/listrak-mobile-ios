//
//  AccountViewController.h
//  SampleMobileStore
//
//  Created by Pamela Vong on 4/19/17.
//  Copyright © 2017 Listrak. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AccountViewController;

@protocol AccountViewControllerDelegate <NSObject>
@required
- (void)accountViewControllerClosed:(AccountViewController *)controller;
@end

@interface AccountViewController : UIViewController

@property (nonatomic, weak) id <AccountViewControllerDelegate> delegate;

- (IBAction)close:(id)sender;

@end
