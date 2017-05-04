//
//  CheckoutViewController.m
//  SampleMobileStore
//
//  Created by Pamela Vong on 4/20/17.
//  Copyright © 2017 Listrak. All rights reserved.
//

#import "CheckoutViewController.h"

@interface CheckoutViewController ()

@end

@implementation CheckoutViewController

- (IBAction)buy:(id)sender {
    id alert = [UIAlertController alertControllerWithTitle:@"Checkout" message:@"Are you sure you're ready to buy?" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Yes"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *action) {
                                                BOOL success = [[Cart sharedInstance] processOrderWithEmail:self.txtEmail.text firstName:self.txtFirstName.text lastName:self.txtLastName.text orderNumber:self.lblOrderNum.text];
                                                if (!success) {
                                                    id alert2 = [UIAlertController alertControllerWithTitle:@"Can't Buy" message:@"Make sure you've filled out all entries before continuing." preferredStyle:UIAlertControllerStyleAlert];
                                                    [alert2 addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                                                    [self presentViewController:alert2 animated:YES completion:nil];
                                                    return;
                                                }
                                                [self dismissViewControllerAnimated:YES completion:nil];
                                            }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}


- (NSString *)getRandomOrderNumber {
    int random1 = arc4random() % 900000 + 100000;
    int random2 = arc4random() % 900000 + 100000;
    
    return [NSString stringWithFormat:@"%i-%i", random1, random2];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    Cart *cart = [Cart sharedInstance];
    Account *account = [Account sharedInstance];
    
    self.lblDescription.text = account.isSignedIn ? @"Verify your information below and click the Buy button at the top-right." : @"Enter your information below and click the Buy button at the top-right.";
    self.lblOrderNum.text = [self getRandomOrderNumber];
    self.lblTotal.text = cart.formattedTotalAmount;
    
    self.txtFirstName.text = account.firstName;
    self.txtLastName.text = account.lastName;
    self.txtEmail.text = account.email;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
