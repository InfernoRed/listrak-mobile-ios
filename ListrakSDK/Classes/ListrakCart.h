//
//  ListrakCart.h
//  Pods
//
//  Created by Pamela Vong on 5/5/17.
//
//

#import <Foundation/Foundation.h>
#import "ListrakCartItem.h"

@interface ListrakCart : NSObject

@property (nonatomic, strong) NSMutableDictionary *items;

+ (NSArray *)cartItems;
+ (ListrakCartItem *)getItemWithSku:(NSString *)sku;
+ (BOOL)hasItemWithSku:(NSString *)sku;
+ (void)addItemWithSku:(NSString *)sku
              quantity:(NSInteger)quantity
                 price:(NSDecimalNumber *)price
                 title:(NSString *)title
              imageUrl:(NSString *)imageUrl
               linkUrl:(NSString *)linkUrl;
+ (void)updateItemQuantityWithSku:(NSString *)sku
                         quantity:(NSInteger)quantity;
+ (void)removeItemWithSku:(NSString *)sku;
+ (void)clearItems;

@end
