//
//  ProductDetailViewController.m
//  SampleMobileStore
//
//  Created by Pamela Vong on 4/18/17.
//  Copyright © 2017 Listrak. All rights reserved.
//

#import "ProductDetailViewController.h"

@interface ProductDetailViewController ()

@end

@implementation ProductDetailViewController

- (void)cartTableViewControllerClosed:(CartTableViewController *)controller;
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)addToCart:(id)sender {
    [[Cart sharedInstance] addProduct:self.productDetail];}

- (IBAction)removeFromCart:(id)sender {
    [[Cart sharedInstance] removeProduct:self.productDetail];}


- (void)cartItemsChangedNotification;
{
    self.navigationItem.rightBarButtonItem.title = [[Cart sharedInstance] formattedCartCount];
    BOOL isInCart = [[Cart sharedInstance] containsProduct:self.productDetail];
    self.btnAdd.hidden = isInCart;
    self.btnRemove.hidden = !isInCart;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = _productDetail.name;
    
    self.lblDescription.text = _productDetail.productDescription;
    
    self.lblSku.text = _productDetail.sku;
    
    self.lblAmount.text = [NSNumberFormatter
                        localizedStringFromNumber:_productDetail.amount
                        numberStyle:NSNumberFormatterCurrencyStyle];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(cartItemsChangedNotification)
     name:CartItemsChangedNotification
     object:nil];
    
    [self cartItemsChangedNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
{
    if ([segue.identifier isEqualToString:@"showCart"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        CartTableViewController *cartViewController = [navigationController viewControllers][0];
        cartViewController.delegate = self;
    }
}

@end
