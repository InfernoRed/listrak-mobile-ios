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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = _productDetail.name;
    
    self.lblDescription.text = _productDetail.productDescription;
    
    self.lblSku.text = _productDetail.sku;
    
    self.lblAmount.text = [NSNumberFormatter
                        localizedStringFromNumber:_productDetail.amount
                        numberStyle:NSNumberFormatterCurrencyStyle];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithTitle:[[Cart sharedInstance] formattedCartCount]
                                              style:UIBarButtonItemStylePlain
                                              target:self
                                              action:nil];
    
    [self update];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addToCart:(id)sender {
    [[Cart sharedInstance] addProduct:self.productDetail];
    [self update];
}

- (IBAction)removeFromCart:(id)sender {
    [[Cart sharedInstance] removeProduct:self.productDetail];
    [self update];
}

- (void)update;
{
    self.navigationItem.rightBarButtonItem.title = [[Cart sharedInstance] formattedCartCount];
    BOOL isInCart = [[Cart sharedInstance] containsProduct:self.productDetail];
    self.btnAdd.hidden = isInCart;
    self.btnRemove.hidden = !isInCart;
}

@end
