//
//  DemoData.m
//  SampleMobileStore
//
//  Created by Pamela Vong on 4/14/17.
//  Copyright © 2017 Listrak. All rights reserved.
//

#import "DemoData.h"
#import "Product.h"

@implementation DemoData

static NSArray *products;

+ (NSArray *)getProducts;
{
    if (!products) {
        products = @[[[Product alloc] initWithName:@"Bluetooth Headphones"
                                       description:@"Wireless headphones with super bass."
                                               sku:@"BHP-100"
                                            amount:[NSDecimalNumber decimalNumberWithString:@"19.99"]]
                     ,[[Product alloc] initWithName:@"Bluetooth Speakers"
                                        description:@"Wireless speakers for you bluetooth-enabled phone."
                                                sku:@"BSP-100"
                                             amount:[NSDecimalNumber decimalNumberWithString:@"49.99"]]
                     ,[[Product alloc] initWithName:@"Bluetooth Adapter"
                                        description:@"Use this adapter to make your normal speakers bluetooth-enabled."
                                                sku:@"ADP-100"
                                             amount:[NSDecimalNumber decimalNumberWithString:@"12.99"]]
                     ,[[Product alloc] initWithName:@"Auto Charging Adapter"
                                        description:@"Charge your phone in the car with this adapter."
                                                sku:@"ADP-200"
                                             amount:[NSDecimalNumber decimalNumberWithString:@"12.99"]]
                     ,[[Product alloc] initWithName:@"USB Charging Cable"
                                        description:@"Extra charging cable for your USB phone"
                                                sku:@"USB-100"
                                             amount:[NSDecimalNumber decimalNumberWithString:@"2.99"]]
                     ,[[Product alloc] initWithName:@"USB Outlet Adapter"
                                        description:@"Adapter to charge your USB phone from a wall outlet."
                                                sku:@"ADP-300"
                                             amount:[NSDecimalNumber decimalNumberWithString:@"5.99"]]
                     ,[[Product alloc] initWithName:@"Phone Case"
                                        description:@"Protect your phone with this awesome, rubberized case."
                                                sku:@"CSE-100"
                                             amount:[NSDecimalNumber decimalNumberWithString:@"39.99"]]
                     ,[[Product alloc] initWithName:@"USB Extension Cable"
                                        description:@"Extend your USB charging cable with this extension cable."
                                                sku:@"EXT-100"
                                             amount:[NSDecimalNumber decimalNumberWithString:@"9.99"]]
                     ];
    }
    
    return products;
}

+ (id)alloc {
    [NSException raise:@"Cannot be instantiated!" format:@"Static class 'ClassName' cannot be instantiated!"];
    return nil;
}

@end
