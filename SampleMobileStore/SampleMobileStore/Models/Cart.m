//
//  Cart.m
//  SampleMobileStore
//
//  Created by Pamela Vong on 4/18/17.
//  Copyright © 2017 Listrak. All rights reserved.
//

#import "Cart.h"

NSString *const CartItemsChangedNotification = @"CartItemsChangedNotification";

@implementation Cart

+ (Cart *)sharedInstance;
{
    static Cart *myInstance = nil;
    if (myInstance == nil) {
        myInstance = [[[self class] alloc] init];
        myInstance.items = [NSMutableDictionary dictionary];
    }
    return myInstance;
}


- (NSArray *)products;
{
    return self.items.allValues;
}

- (NSUInteger)productsCount;
{
    return self.items.count;
}

- (NSString *)formattedCartCount;
{
    return [NSString stringWithFormat:@"Cart(%i)", [self productsCount]];
}

- (NSDecimalNumber *)totalAmount;
{
    return [self.items.allValues valueForKeyPath:@"@sum.amount"];
}

- (NSString *)formattedTotalAmount;
{
    return [NSNumberFormatter
            localizedStringFromNumber:self.totalAmount
            numberStyle:NSNumberFormatterCurrencyStyle];
}

- (BOOL)containsProduct:(Product *)item;
{
    return [self.items.allValues containsObject:item];
}

- (void)addProduct:(Product *)item;
{
    if (![self containsProduct:item]){
        self.items[item.sku] = item;
        [self notifyItemsChanged];
        // TODO: invoke SDK's addItem
    }
}

- (void)removeProduct:(Product *)item;
{
    [self.items removeObjectForKey:item.sku];
    [self notifyItemsChanged];
    // TODO: invoke SDK's removeItem
}

- (void)clearProducts;
{
    [self.items removeAllObjects];
    [self notifyItemsChanged];
    
    // TODO: invoke SDK's clearItems
}

- (void)notifyItemsChanged;
{
    [[NSNotificationCenter defaultCenter]
     postNotificationName:CartItemsChangedNotification
     object:self];
}

- (BOOL)processOrderWithEmail:(NSString *)email firstName:(NSString *)firstName lastName:(NSString *)lastName orderNumber:(NSString *)orderNumber);
{
    if (email.length != 0 && firstName.length != 0 && lastName.length != 0 && orderNumber.length != 0) {
        // TODO: send Order info to SDK
        
        [[Cart sharedInstance] clearProducts];
        
        return YES;
    } else {
        return NO;
    }
}

@end
