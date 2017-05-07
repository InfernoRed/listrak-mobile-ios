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

+ (void *)submitOrder:(ListrakOrder *)order {
    if (order == nil) {
        [NSException raise:NSInvalidArgumentException format:@"order cannot be null"];
    }

    //var svc = Config.Container.Create<IListrakService>();

    // TODO: submit the order
    //svc.SubmitOrder(order);

    // TODO: prevent SCA emails
    //svc.FinalizeCart(order.OrderNumber, order.EmailAddress, order.FirstName, order.LastName);

    // TODO: the session id needs to be reset after each order
    //Session.Reset();
}

@end
