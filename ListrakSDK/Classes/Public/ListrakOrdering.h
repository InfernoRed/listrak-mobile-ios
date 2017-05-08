//
//  ListrakOrdering.h
//  ListrakSDK
//
//  Created by Pamela Vong on 5/6/17.
//
//

#import <Foundation/Foundation.h>

@class ListrakOrder;

@interface ListrakOrdering : NSObject

+ (ListrakOrder *)createOrder;
+ (ListrakOrder *)createOrderFromCart;
+ (void)submitOrder:(ListrakOrder *)order;

@end
