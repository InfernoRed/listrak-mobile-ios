//
//  ListrakCartItem.m
//  ListrakSDK
//
//  Created by Pamela Vong on 5/5/17.
//  Copyright © 2017 Listrak. All rights reserved.
//

#import "ListrakCartItem.h"
#import "ListrakCartItemExtension.h"


@implementation ListrakCartItem {

}

- (ListrakCartItem *) initWithSku:(NSString *)sku
                         quantity:(NSInteger)quantity
                            price:(NSDecimalNumber *)price
                            title:(NSString *)title
                         imageUrl:(NSString *)imageUrl
                          linkUrl:(NSString *)linkUrl {
    self = [super init];
    if (self) {
        self.sku = sku;
        self.quantity = quantity;
        self.price = price;
        self.title = title;
        self.imageUrl = imageUrl;
        self.linkUrl = linkUrl;
    }
    return self;
}
@end
