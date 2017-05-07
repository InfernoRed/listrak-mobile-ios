//
//  ListrakOrder.m
//  ListrakSDK
//
//  Created by Pamela Vong on 5/6/17.
//
//

#import "ListrakOrder.h"
#import "ListrakItem.h"
#import "ListrakItemExtension.h"
#import "ListrakSession.h"

@implementation ListrakOrder

#pragma mark  - Initialization

- (ListrakOrder *)init {
    self = [super init];
    if (self) {
        _items = [NSMutableDictionary dictionary];
        _emailAddress = @"";
        _firstName = @"";
        _lastName = @"";
        self.currency = @"";
        self.orderNumber = @"";
        self.orderTotal = @0;
        self.taxTotal = @0;
        self.shippingTotal = @0;
        self.handlingTotal = @0;
    }
    return self;
}

#pragma mark - Public Instance Members

- (void)addItemWithSku:(NSString *)sku
              quantity:(NSInteger)quantity
                 price:(NSDecimalNumber *)price {
    if (sku.length == 0) {
        [NSException raise:NSInvalidArgumentException format:@"sku cannot be null or empty"];
    }
    if (quantity <= 0) {
        [NSException raise:NSInvalidArgumentException format:@"quantity must be greater than 0"];
    }

    ListrakItem *item = [[ListrakItem alloc] initWithSku:sku
                                                quantity:quantity
                                                   price:price];

    self.items[sku] = item;

}

- (void)setCustomerWithEmailAddress:(NSString *)emailAddress
                          firstName:(NSString *)firstName
                           lastName:(NSString *)lastName {
    if (emailAddress.length == 0) {
        [NSException raise:NSInvalidArgumentException format:@"emailAddress cannot be null or empty"];
    }

    _emailAddress = emailAddress;
    _firstName = firstName;
    _lastName = lastName;
}

- (void)setCustomerFromSession {
    [self setCustomerWithEmailAddress:ListrakSession.emailAddress firstName:ListrakSession.firstName lastName:ListrakSession.lastName];
}

@end
