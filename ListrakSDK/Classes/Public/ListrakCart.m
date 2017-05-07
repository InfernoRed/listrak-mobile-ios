//
//  ListrakCart.m
//  ListrakSDK
//
//  Created by Pamela Vong on 5/5/17.
//
//

#import "ListrakCart.h"
#import "ListrakCartItemExtension.h"


@implementation ListrakCart

#pragma mark - Internal Singleton Initialization

+ (ListrakCart *)sharedInstance {
    static ListrakCart *myInstance = nil;
    if (myInstance == nil) {
        myInstance = [[[self class] alloc] init];
        myInstance.items = [NSMutableDictionary dictionary];
    }
    return myInstance;
}

#pragma mark - Public Static Members

+ (NSArray *)cartItems {
    return [[self sharedInstance] cartItems];
}

+ (ListrakCartItem *)getItemWithSku:(NSString *)sku {
    return [[self sharedInstance] getItemWithSku:sku];
}

+ (BOOL)hasItemWithSku:(NSString *)sku {
    return [[self sharedInstance] hasItemWithSku:sku];
}

+ (void)addItemWithSku:(NSString *)sku
              quantity:(NSInteger)quantity
                 price:(NSDecimalNumber *)price
                 title:(NSString *)title
              imageUrl:(NSString *)imageUrl
               linkUrl:(NSString *)linkUrl {
    [[self sharedInstance] addItemWithSku:sku quantity:quantity price:price title:title imageUrl:imageUrl linkUrl:linkUrl];
}

+ (void)updateItemQuantityWithSku:(NSString *)sku
                         quantity:(NSInteger)quantity {
    [[self sharedInstance] updateItemQuantityWithSku:sku quantity:quantity];
}

+ (void)removeItemWithSku:(NSString *)sku {
    [[self sharedInstance] removeItemWithSku:sku];
}

+ (void)clearItems {
    [[self sharedInstance] clearItems];
}

#pragma mark - Internal Instance Members

- (NSArray *)cartItems {
    return self.items.allValues;
}

- (ListrakCartItem *)getItemWithSku:(NSString *)sku {
    if (sku.length == 0) {
        [NSException raise:NSInvalidArgumentException format:@"sku cannot be null or empty"];
    }
    if (![self hasItemWithSku:sku]) {
        return nil;
    }
    return [self.items valueForKey:sku];
}

- (BOOL)hasItemWithSku:(NSString *)sku {
    if (sku.length == 0) {
        [NSException raise:NSInvalidArgumentException format:@"sku cannot be null or empty"];
    }
    return [self.items.allKeys containsObject:sku];
}

- (void)addItemWithSku:(NSString *)sku
              quantity:(NSInteger)quantity
                 price:(NSDecimalNumber *)price
                 title:(NSString *)title
              imageUrl:(NSString *)imageUrl
               linkUrl:(NSString *)linkUrl {
    if (sku.length == 0) {
        [NSException raise:NSInvalidArgumentException format:@"sku cannot be null or empty"];
    }
    if (title.length == 0) {
        [NSException raise:NSInvalidArgumentException format:@"title cannot be null or empty"];
    }
    if (quantity <= 0) {
        [NSException raise:NSInvalidArgumentException format:@"quantity must be greater than 0"];
    }
    
    ListrakCartItem *cartItem = [[ListrakCartItem alloc] initWithSku:sku
                                                            quantity:quantity
                                                               price:price
                                                               title:title
                                                            imageUrl:imageUrl
                                                             linkUrl:linkUrl];
    
    self.items[sku] = cartItem;

    [self updateCart];
}

- (void)updateItemQuantityWithSku:(NSString *)sku
                         quantity:(NSInteger)quantity {
    if (sku.length == 0) {
        [NSException raise:NSInvalidArgumentException format:@"sku cannot be null or empty"];
    }
    if (quantity <= 0) {
        [NSException raise:NSInvalidArgumentException format:@"quantity must be greater than 0"];
    }
    if (![self hasItemWithSku:sku]) {
        [NSException raise:NSUndefinedKeyException format:@"cart does not contain the specified sku"];
    }

    ListrakCartItem *item = [self getItemWithSku:sku];
    [item setQuantity:quantity];

    [self updateCart];
}

- (void)removeItemWithSku:(NSString *)sku {
    if (sku.length == 0) {
        [NSException raise:NSInvalidArgumentException format:@"sku cannot be null or empty"];
    }
    if (![self hasItemWithSku:sku]) {
        [NSException raise:NSUndefinedKeyException format:@"cart does not contain the specified sku"];
    }

    [self.items removeObjectForKey:sku];

    [self updateCart];
}

- (void)clearItems {
    [self.items removeAllObjects];
    // TODO: call service to clear cart items
}


- (void)updateCart {
    // TODO: call service to update cart items
}

@end
