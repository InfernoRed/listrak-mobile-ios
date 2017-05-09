//
//  ListrakService.h
//  ListrakSDK
//
//  Created by Pamela Vong on 5/8/17.
//
//

#import <Foundation/Foundation.h>

@class ListrakOrder;

@interface ListrakService : NSObject

+ (ListrakService *)getInstance;
+ (void)setInstance:(ListrakService *)service;

+ (void)trackProductBrowseWithSku:(NSArray *)skus;
+ (void)captureCustomerWithEmail:(NSString *)email;
+ (void)clearCart;
+ (void)updateCartWithCartItems:(NSArray *)cartItems;
+ (void)submitOrder:(ListrakOrder *)order;
+ (void)finalizeCartWithOrderNumber:(NSString *)orderNumber
                       emailAddress:(NSString *)email
                          firstName:(NSString *)firstName
                           lastName:(NSString *)lastName;
+ (void)subscribeCustomerWithSubscriberCode:(NSString *)code
                               emailAddress:(NSString *)email
                                       meta:(NSDictionary *)meta;

@end
