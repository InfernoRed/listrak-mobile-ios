//
//  Cart.m
//  SampleMobileStore
//
//  Created by Pamela Vong on 4/18/17.
//  Copyright © 2017 Listrak. All rights reserved.
//

#import "Cart.h"


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
    return [self.items.allValues valueForKeyPath:@"@sum.self"];
}

- (NSString *)formattedTotalAmount;
{
    id total = [self formattedTotalAmount];
    return [NSNumberFormatter
            localizedStringFromNumber:total
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
        [self.delegate processItemsChanged];
        // TODO: invoke SDK's addItem
    }
}

- (void)removeProduct:(Product *)item;
{
    [self.items removeObjectForKey:item.sku];
    [self.delegate processItemsChanged];
    // TODO: invoke SDK's removeItem
}

- (void)clearProducts;
{
    [self.items removeAllObjects];
    [self.delegate processItemsChanged];
    // TODO: invoke SDK's clearItems
}

@end
