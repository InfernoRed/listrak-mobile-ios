//
//  CartFooterView.m
//  SampleMobileStore
//
//  Created by Pamela Vong on 4/20/17.
//  Copyright © 2017 Listrak. All rights reserved.
//

#import "CartFooterView.h"

@implementation CartFooterView

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(cartItemsChangedNotification)
     name:CartItemsChangedNotification
     object:nil];
    
    return self;
}

- (void)layoutSubviews {
    [self cartItemsChangedNotification];
}

- (void)cartItemsChangedNotification {
    self.lblTotal.text = [[Cart sharedInstance] formattedTotalAmount];
    BOOL hasProducts = [[Cart sharedInstance] productsCount] > 0;
    
    self.lblInstructions.text = hasProducts ? @"Click on an item to remove it" : @"Cart is empty";
    self.btnCheckout.hidden = !hasProducts;
    self.btnClear.hidden = !hasProducts;
    self.vwBorder.hidden = !hasProducts;
}

- (void)clear:(id)sender {
    [[Cart sharedInstance] clearProducts];
}

@end
