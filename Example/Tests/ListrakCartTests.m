//
//  ListrakCartTests.m
//  ListrakSDKTests
//
//  Created by Pamela Vong on 05/04/2017.
//  Copyright (c) 2017 Listrak. All rights reserved.
//

// https://github.com/Specta/Specta

#import <ListrakSDK/ListrakCart.h>

SpecBegin(ListrakCart)

describe(@"ListrakCart", ^{

    describe(@"adding cart items", ^{

        describe(@"with valid arguments", ^{
            __block NSUInteger initialCount;
            __block NSString *sku = @"test-sku";

            beforeAll(^{
                initialCount = [ListrakCart.cartItems count];
                [ListrakCart addItemWithSku:sku
                                   quantity:1
                                      price:[NSDecimalNumber decimalNumberWithString:@"1.0"]
                                      title:@"test-title"
                                   imageUrl:nil
                                    linkUrl:nil];
            });

            it(@"increases count of cartItems by 1", ^{
                assertThatUnsignedInteger([ListrakCart.cartItems count], equalToUnsignedInteger((NSUInteger) (initialCount + 1)));
            });

            it(@"contains cartItem with given SKU", ^{
                assertThatBool([ListrakCart hasItemWithSku:sku], isTrue());
            });

            it(@"retrieves a cartItem object for the given SKU", ^{
                ListrakCartItem *item = [ListrakCart getItemWithSku:sku];
                assertThat(item, notNilValue());
            });
        });

        describe(@"with invalid arguments", ^ {
            it(@"throws exception for nil sku", ^{
                assertThat(^{
                    [ListrakCart addItemWithSku:nil
                                       quantity:1
                                          price:[NSDecimalNumber decimalNumberWithString:@"1.0"]
                                          title:@"test-title"
                                       imageUrl:nil
                                        linkUrl:nil];
                }, throwsException(hasProperty(@"name", NSInvalidArgumentException)));
            });

            it(@"throws exception for nil title", ^{
                assertThat(^{
                    [ListrakCart addItemWithSku:@"test-sku-0"
                                       quantity:1
                                          price:[NSDecimalNumber decimalNumberWithString:@"1.0"]
                                          title:nil
                                       imageUrl:nil
                                        linkUrl:nil];
                }, throwsException(hasProperty(@"name", NSInvalidArgumentException)));
            });

            it(@"throws exception for 0 quantity", ^{
                assertThat(^{
                    [ListrakCart addItemWithSku:@"test-sku-0"
                                       quantity:0
                                          price:[NSDecimalNumber decimalNumberWithString:@"1.0"]
                                          title:@"test-title"
                                       imageUrl:nil
                                        linkUrl:nil];
                }, throwsException(hasProperty(@"name", NSInvalidArgumentException)));
            });
        });
    });

    describe(@"updating cart item quantity", ^{
        __block NSString *sku = @"test-sku-1";
        it(@"updates the quantity value", ^{
            [ListrakCart addItemWithSku:sku
                               quantity:1
                                  price:[NSDecimalNumber decimalNumberWithString:@"1.0"]
                                  title:@"test-title"
                               imageUrl:nil
                                linkUrl:nil];
            [ListrakCart updateItemQuantityWithSku:sku quantity:2];
            ListrakCartItem *item = [ListrakCart getItemWithSku:sku];
            assertThatInteger((int) item.quantity, equalTo(@2));
        });

        it(@"throws exception for nil sku", ^{
            assertThat(^{
                [ListrakCart updateItemQuantityWithSku:nil quantity:2];
            }, throwsException(hasProperty(@"name", NSInvalidArgumentException)));
        });

        it(@"throws exception for 0 quantity", ^{
            assertThat(^{
                [ListrakCart updateItemQuantityWithSku:sku quantity:0];
            }, throwsException(hasProperty(@"name", NSInvalidArgumentException)));
        });

        it(@"throws exception if sku doesn't exist", ^{
            assertThat(^{
                [ListrakCart updateItemQuantityWithSku:@"non-existent-sku" quantity:1];
            }, throwsException(hasProperty(@"name", NSUndefinedKeyException)));
        });
    });

    describe(@"removing cart items", ^{
        it(@"removes a valid cartItem for the given SKU with the count equal to the initial count", ^{
            NSUInteger initialCount = [ListrakCart.cartItems count];
            [ListrakCart addItemWithSku:@"test-sku2"
                                                quantity:1
                                                   price:[NSDecimalNumber decimalNumberWithString:@"1.0"]
                                                   title:@"test-title"
                                                imageUrl:nil
                                                 linkUrl:nil];
            [ListrakCart removeItemWithSku:@"test-sku2"];
            assertThatUnsignedInteger([ListrakCart.cartItems count], equalToInteger(initialCount));
        });

        it(@"throws exception if sku is nil", ^{
            assertThat(^{
                [ListrakCart removeItemWithSku:nil];
            }, throwsException(hasProperty(@"name", NSInvalidArgumentException)));
        });

        it(@"throws exception if sku doesn't exist", ^{
            assertThat(^{
                [ListrakCart removeItemWithSku:@"non-existent-sku"];
            }, throwsException(hasProperty(@"name", NSUndefinedKeyException)));
        });
    });

    describe(@"clear items", ^{
       it(@"returns cart item count to 0", ^{
          [ListrakCart addItemWithSku:@"test-sku-3"
                             quantity:1
                                price:[NSDecimalNumber decimalNumberWithString:@"1.0"]
                                title:@"test-title"
                             imageUrl:nil
                              linkUrl:nil];
           [ListrakCart clearItems];

           assertThatInteger((int) [ListrakCart.cartItems count], equalTo(@0));
       });
    });
});


SpecEnd

