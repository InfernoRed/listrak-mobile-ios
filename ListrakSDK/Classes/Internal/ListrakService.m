//
//  ListrakService.m
//  Pods
//
//  Created by Pamela Vong on 5/8/17.
//
//

#import "ListrakService.h"
#import "ListrakOrder.h"

static ListrakService* singletonInstance;

@implementation ListrakService

#pragma mark - Singleton Getter and Setter

+ (ListrakService *)getInstance {
    if (singletonInstance == nil) {
        singletonInstance = [[ListrakService alloc] init];
    }
    return singletonInstance;
}

// for testing with mocks
+ (void)setInstance:(ListrakService *)service {
    singletonInstance = service;
}

#pragma mark - Public Static Members

+ (void)trackProductBrowseWithSku:(NSArray *)skus {
    [self.getInstance trackProductBrowseWithSku:skus];
}

+ (void)captureCustomerWithEmail:(NSString *)email {
    [self.getInstance captureCustomerWithEmail:email];
}

+ (void)clearCart {
    [self.getInstance clearCart];
}

+ (void)updateCartWithCartItems:(NSArray *)cartItems {
    [self.getInstance updateCartWithCartItems:cartItems];
}

+ (void)submitOrder:(ListrakOrder *)order {
    [self.getInstance submitOrder:order];
}

+ (void)finalizeCartWithOrderNumber:(NSString *)orderNumber
                       emailAddress:(NSString *)email
                          firstName:(NSString *)firstName
                           lastName:(NSString *)lastName {
    [self.getInstance finalizeCartWithOrderNumber:orderNumber
                                     emailAddress:email
                                        firstName:firstName
                                         lastName:lastName];
}

+ (void)subscribeCustomerWithSubscriberCode:(NSString *)code
                               emailAddress:(NSString *)email
                                       meta:(NSDictionary *)meta {
    [self.getInstance subscribeCustomerWithSubscriberCode:code
                                             emailAddress:email
                                                     meta:meta];
}

#pragma mark - Private Instance Members

- (void)trackProductBrowseWithSku:(NSArray *)skus {
    int i = 0;
}

- (void)captureCustomerWithEmail:(NSString *)email {

}

- (void)clearCart {

}

- (void)updateCartWithCartItems:(NSArray *)cartItems {

}

- (void)submitOrder:(ListrakOrder *)order {

}

- (void)finalizeCartWithOrderNumber:(NSString *)orderNumber
                       emailAddress:(NSString *)email
                          firstName:(NSString *)firstName
                           lastName:(NSString *)lastName {

}

- (void)subscribeCustomerWithSubscriberCode:(NSString *)code
                               emailAddress:(NSString *)email
                                       meta:(NSDictionary *)meta {

}

@end
