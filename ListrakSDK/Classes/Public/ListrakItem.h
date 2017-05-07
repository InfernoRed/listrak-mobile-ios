//
//  ListrakItem.h
//  ListrakSDK
//
//  Created by Pamela Vong on 5/5/17.
//  Copyright © 2017 Listrak. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ListrakItem : NSObject

@property (nonatomic, readonly, strong) NSString *sku;
@property (nonatomic, readonly) NSInteger quantity;
@property (nonatomic, readonly, strong) NSDecimalNumber *price;

@end
