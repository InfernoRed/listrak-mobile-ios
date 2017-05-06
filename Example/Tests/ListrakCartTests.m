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
                expect([ListrakCart.cartItems count]).to.equal(initialCount + 1);
            });

            it(@"contains cartItem with given SKU", ^{
                expect([ListrakCart hasItemWithSku:sku]).to.equal(YES);
            });

            it(@"retrieves a cartItem object for the given SKU", ^{
                ListrakCartItem *item = [ListrakCart getItemWithSku:sku];
                expect(item).notTo.beNil();
            });
        });

        describe(@"with invalid arguments", ^ {
            it(@"throws exception for nil sku", ^{
                expect(^{
                    [ListrakCart addItemWithSku:nil
                                       quantity:1
                                          price:[NSDecimalNumber decimalNumberWithString:@"1.0"]
                                          title:@"test-title"
                                       imageUrl:nil
                                        linkUrl:nil];
                }).to.raise(NSInvalidArgumentException);
            });

            it(@"throws exception for nil title", ^{
                expect(^{
                    [ListrakCart addItemWithSku:@"test-sku-0"
                                       quantity:1
                                          price:[NSDecimalNumber decimalNumberWithString:@"1.0"]
                                          title:nil
                                       imageUrl:nil
                                        linkUrl:nil];
                }).to.raise(NSInvalidArgumentException);
            });

            it(@"throws exception for 0 quantity", ^{
                expect(^{
                    [ListrakCart addItemWithSku:@"test-sku-0"
                                       quantity:0
                                          price:[NSDecimalNumber decimalNumberWithString:@"1.0"]
                                          title:@"test-title"
                                       imageUrl:nil
                                        linkUrl:nil];
                }).to.raise(NSInvalidArgumentException);
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
            expect(item.quantity).to.equal(2);
        });

        it(@"throws exception for nil sku", ^{
            expect(^{
                [ListrakCart updateItemQuantityWithSku:nil quantity:2];
            }).to.raise(NSInvalidArgumentException);
        });

        it(@"throws exception for 0 quantity", ^{
            expect(^{
                [ListrakCart updateItemQuantityWithSku:sku quantity:0];
            }).to.raise(NSInvalidArgumentException);
        });

        it(@"throws exception if sku doesn't exist", ^{
            expect(^{
                [ListrakCart updateItemQuantityWithSku:@"non-existent-sku" quantity:1];
            }).to.raise(NSUndefinedKeyException);
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
            expect([ListrakCart.cartItems count]).to.equal(initialCount);
        });

        it(@"throws exception if sku is nil", ^{
            expect(^{
                [ListrakCart removeItemWithSku:nil];
            }).to.raise(NSInvalidArgumentException);
        });

        it(@"throws exception if sku doesn't exist", ^{
            expect(^{
                [ListrakCart removeItemWithSku:@"non-existent-sku"];
            }).to.raise(NSUndefinedKeyException);
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

           expect([ListrakCart.cartItems count]).to.equal(0);
       });
    });
});


SpecEnd

