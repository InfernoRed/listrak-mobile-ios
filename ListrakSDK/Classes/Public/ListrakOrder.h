//
//  ListrakOrder.h
//  ListrakSDK
//
//  Created by Pamela Vong on 5/6/17.
//
//

#import <Foundation/Foundation.h>

@interface ListrakOrder : NSObject

@property (nonatomic, readonly, strong) NSMutableDictionary *items;
@property (nonatomic, readonly, strong) NSString *emailAddress;
@property (nonatomic, readonly, strong) NSString *firstName;
@property (nonatomic, readonly, strong) NSString *lastName;
@property (nonatomic, strong) NSString *currency;
@property (nonatomic, strong) NSString *orderNumber;
@property (nonatomic, strong) NSDecimalNumber *orderTotal;
@property (nonatomic, strong) NSDecimalNumber *taxTotal;
@property (nonatomic, strong) NSDecimalNumber *shippingTotal;
@property (nonatomic, strong) NSDecimalNumber *handlingTotal;

- (void)addItemWithSku:(NSString *)sku
             quantity:(NSInteger)quantity
                price:(NSDecimalNumber *)price;
- (void)setCustomerWithEmailAddress:(NSString *)emailAddress
                          firstName:(NSString *)firstName
                           lastName:(NSString *)lastName;
- (void)setCustomerFromSession;

@end
