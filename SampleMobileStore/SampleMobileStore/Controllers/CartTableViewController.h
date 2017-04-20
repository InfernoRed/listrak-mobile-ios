//
//  CartTableViewController.h
//  SampleMobileStore
//
//  Created by Pamela Vong on 4/19/17.
//  Copyright © 2017 Listrak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "Cart.h"
#import "CartTableViewCell.h"

@class CartTableViewController;

@protocol CartTableViewControllerDelegate <NSObject>
@required
- (void)cartTableViewControllerClosed:(CartTableViewController *)controller;
@end

@interface CartTableViewController : UITableViewController {
    NSArray *products;
}

@property (nonatomic, weak) id <CartTableViewControllerDelegate> delegate;

- (IBAction)close:(id)sender;

@end
