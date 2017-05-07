//
//  ListrakItemPrivate.h
//  ListrakSDK
//
//  Created by Pamela Vong on 5/5/17.
//  Copyright © 2017 Listrak. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ListrakItem ()

@property (nonatomic, readwrite, strong) NSString *sku;
@property (nonatomic, readwrite) NSInteger quantity;
@property (nonatomic, readwrite, strong) NSDecimalNumber *price;

- (ListrakItem *) initWithSku:(NSString *)sku
                     quantity:(NSInteger)quantity
                        price:(NSDecimalNumber *)price;

@end
