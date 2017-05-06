//
//  ListrakCartItemPrivate.h
//  ListrakSDK
//
//  Created by Pamela Vong on 5/5/17.
//  Copyright © 2017 Listrak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListrakItemExtension.h"


@interface ListrakCartItem ()

@property (nonatomic, readwrite, strong) NSString *title;
@property (nonatomic, readwrite, strong) NSString *imageUrl;
@property (nonatomic, readwrite, strong) NSString *linkUrl;

- (ListrakCartItem *) initWithSku:(NSString *)sku
                     quantity:(NSInteger)quantity
                        price:(NSDecimalNumber *)price
                            title:(NSString *)title
                         imageUrl:(NSString *)imageUrl
                          linkUrl:(NSString *)linkUrl;

@end
