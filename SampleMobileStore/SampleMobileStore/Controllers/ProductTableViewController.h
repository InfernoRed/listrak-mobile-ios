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
#import "Cart.h"
#import "ProductTableViewCell.h"
#import "ProductDetailViewController.h"

@interface ProductTableViewController : UITableViewController<CartDelegate> {
    NSArray *products;
}


@end
