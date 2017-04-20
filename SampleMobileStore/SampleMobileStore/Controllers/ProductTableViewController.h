//
//  ProductTableViewController.h
//  SampleMobileStore
//
//  Created by Pamela Vong on 4/14/17.
//  Copyright © 2017 Listrak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "DemoData.h"
#import "Account.h"
#import "Cart.h"
#import "ProductTableViewCell.h"
#import "ProductDetailViewController.h"
#import "AccountViewController.h"
#import "CartTableViewController.h"

@interface ProductTableViewController : UITableViewController<CartTableViewControllerDelegate, AccountViewControllerDelegate> {
    NSArray *products;
}


@end
