//
//  ListrakItem.m
//  ListrakSDK
//
//  Created by Pamela Vong on 5/5/17.
//  Copyright © 2017 Listrak. All rights reserved.
//


#import "ListrakItem.h"
#import "ListrakItemExtension.h"


@implementation ListrakItem {

}

- (ListrakItem *) initWithSku:(NSString *)sku
                     quantity:(NSInteger)quantity
                        price:(NSDecimalNumber *)price {
    self = [super init];
    if (self) {
        self.sku = sku;
        self.quantity = quantity;
        self.price = price;
    }
    return self;
}

@end
