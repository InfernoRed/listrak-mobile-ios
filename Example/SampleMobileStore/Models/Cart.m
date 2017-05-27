//
//  Cart.m
//  SampleMobileStore
//
//  Created by Pamela Vong on 4/18/17.
//  Copyright © 2017 Listrak. All rights reserved.
//

#import <ListrakSDK/ListrakCart.h>
#import <ListrakSDK/ListrakOrder.h>
#import <ListrakSDK/ListrakOrdering.h>
#import "Cart.h"

NSString *const CartItemsChangedNotification = @"CartItemsChangedNotification";

@implementation Cart

+ (Cart *)sharedInstance {
    static Cart *myInstance = nil;
    if (myInstance == nil) {
        myInstance = [[[self class] alloc] init];
        myInstance.items = [NSMutableDictionary dictionary];
    }
    return myInstance;
}


- (NSArray *)products {
    return self.items.allValues;
}

- (NSUInteger)productsCount {
    return self.items.count;
}

- (NSString *)formattedCartCount {
    return [NSString stringWithFormat:@"Cart(%lu)", (unsigned long)[self productsCount]];
}

- (NSDecimalNumber *)totalAmount {
    return [self.items.allValues valueForKeyPath:@"@sum.amount"];
}

- (NSString *)formattedTotalAmount {
    return [NSNumberFormatter
            localizedStringFromNumber:self.totalAmount
            numberStyle:NSNumberFormatterCurrencyStyle];
}

- (BOOL)containsProduct:(Product *)item {
    return [self.items.allValues containsObject:item];
}

- (void)addProduct:(Product *)item {
    if (![self containsProduct:item]){
        self.items[item.sku] = item;
        [self notifyItemsChanged];

        // LISTRAK SDK
        // let the sdk know we have added a new cart item
        //
        [ListrakCart addItemWithSku:item.sku
                           quantity:1
                              price:item.amount
                              title:item.name
                           imageUrl:nil
                            linkUrl:nil];
    }
}

- (void)removeProduct:(Product *)item {
    [self.items removeObjectForKey:item.sku];
    [self notifyItemsChanged];

    // LISTRAK SDK
    // let the sdk know we are removing a cart item
    //
    [ListrakCart removeItemWithSku:item.sku];
}

- (void)clearProducts {
    [self.items removeAllObjects];
    [self notifyItemsChanged];
    
    // LISTRAK SDK
    // have the sdk clear all cart items
    //
    [ListrakCart clearItems];
}

- (void)notifyItemsChanged {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:CartItemsChangedNotification
     object:self];
}

- (BOOL)processOrderWithEmail:(NSString *)email firstName:(NSString *)firstName lastName:(NSString *)lastName orderNumber:(NSString *)orderNumber {
    if (email.length != 0 && firstName.length != 0 && lastName.length != 0 && orderNumber.length != 0) {

        // LISTRAK SDK
        // create an order from our cart and set necessary info
        // once order has been filled-out, submit it
        //
        ListrakOrder *order = [ListrakOrdering createOrderFromCart];
        [order setCustomerWithEmailAddress:email
                                 firstName:firstName
                                  lastName:lastName];
        order.orderNumber = orderNumber;
        order.orderTotal = self.totalAmount;
        [ListrakOrdering submitOrder:order];

        [[Cart sharedInstance] clearProducts];
        
        return YES;
    } else {
        return NO;
    }
}

@end
