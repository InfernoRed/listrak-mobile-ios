//
//  Cart.h
//  SampleMobileStore
//
//  Created by Pamela Vong on 4/18/17.
//  Copyright © 2017 Listrak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"
#import "ListrakCart.h"

extern NSString *const CartItemsChangedNotification;

@interface Cart : NSObject

@property (nonatomic, strong) NSMutableDictionary *items;

+ (Cart *)sharedInstance;

- (NSArray *)products;
- (NSUInteger)productsCount;
- (NSString *)formattedCartCount;
- (NSDecimalNumber *)totalAmount;
- (NSString *)formattedTotalAmount;
- (BOOL)containsProduct:(Product *)item;
- (void)addProduct:(Product *)item;
- (void)removeProduct:(Product *)item;
- (void)clearProducts;
- (BOOL)processOrderWithEmail:(NSString *)email firstName:(NSString *)firstName lastName:(NSString *)lastName orderNumber:(NSString *)orderNumber;

@end
