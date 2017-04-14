//
//  Product.h
//  SampleMobileStore
//
//  Created by Pamela Vong on 4/14/17.
//  Copyright © 2017 Listrak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *productDescription;
@property (nonatomic, strong) NSString *sku;
@property (nonatomic, strong) NSDecimalNumber *amount;

- (Product *) initWithName:(NSString *)name
               description:(NSString *)productDescription
                       sku:(NSString *)sku
                    amount:(NSDecimalNumber *)amount;

@end
