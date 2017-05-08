//
//  ListrakOrdering.m
//  ListrakSDK
//
//  Created by Pamela Vong on 5/6/17.
//
//

#import "ListrakOrdering.h"
#import "ListrakOrder.h"
#import "ListrakCart.h"
#import "ListrakItemExtension.h"
#import "ListrakService.h"
#import "ListrakSession.h"
#import "ListrakSessionExtension.h"

@implementation ListrakOrdering

#pragma mark - Public Static Members

+ (ListrakOrder *)createOrder {
    return [[ListrakOrder alloc] init];
}

+ (ListrakOrder *)createOrderFromCart {
    ListrakOrder *order = [ListrakOrdering createOrder];
    NSArray *cartItems = ListrakCart.cartItems;

    for (ListrakCartItem *item in cartItems) {
        [order addItemWithSku:item.sku quantity:item.quantity price:item.price];
    }

    return order;
}

+ (void)submitOrder:(ListrakOrder *)order {
    if (order == nil) {
        [NSException raise:NSInvalidArgumentException format:@"order cannot be null"];
    }

    // submit the order
    [ListrakService submitOrder:order];

    // prevent SCA emails
    [ListrakService finalizeCartWithOrderNumber:order.orderNumber
                                   emailAddress:order.emailAddress
                                      firstName:order.firstName
                                       lastName:order.lastName];

    // the session id needs to be reset after each order
    [ListrakSession reset];
}

@end
