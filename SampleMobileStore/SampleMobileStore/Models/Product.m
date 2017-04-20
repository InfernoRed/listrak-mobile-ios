//
//  Product.m
//  SampleMobileStore
//
//  Created by Pamela Vong on 4/14/17.
//  Copyright © 2017 Listrak. All rights reserved.
//

#import "Product.h"

@implementation Product

- (Product *)initWithName:(id)name
              description:(id)productDescription
                      sku:(id)sku
                   amount:(id)amount;
{
    self = [super init];
    if (self) {
        self.name = name;
        self.productDescription = productDescription;
        self.sku = sku;
        self.amount = amount;
    }
    return self;
}

@end
