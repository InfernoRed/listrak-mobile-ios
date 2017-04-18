//
//  ProductDetailViewController.h
//  SampleMobileStore
//
//  Created by Pamela Vong on 4/18/17.
//  Copyright © 2017 Listrak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "Cart.h"

@interface ProductDetailViewController : UIViewController

@property (strong, nonatomic) Product *productDetail;

@property (strong, nonatomic) IBOutlet UILabel *lblDescription;
@property (strong, nonatomic) IBOutlet UILabel *lblSku;
@property (strong, nonatomic) IBOutlet UILabel *lblAmount;
@property (strong, nonatomic) IBOutlet UIButton *btnAdd;
@property (strong, nonatomic) IBOutlet UIButton *btnRemove;

- (IBAction)addToCart:(id)sender;
- (IBAction)removeFromCart:(id)sender;

@end
