//
//  CheckoutViewController.h
//  SampleMobileStore
//
//  Created by Pamela Vong on 4/20/17.
//  Copyright © 2017 Listrak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Account.h"
#import "Cart.h"

@interface CheckoutViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *lblDescription;
@property (strong, nonatomic) IBOutlet UILabel *lblOrderNum;
@property (strong, nonatomic) IBOutlet UILabel *lblTotal;
@property (strong, nonatomic) IBOutlet UITextField *txtFirstName;
@property (strong, nonatomic) IBOutlet UITextField *txtLastName;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;

- (IBAction)buy:(id)sender;

@end
