//
//  ListrakOrderTests.m
//  ListrakSDKTests
//
//  Created by Pamela Vong on 05/04/2017.
//  Copyright (c) 2017 Listrak. All rights reserved.
//

// https://github.com/Specta/Specta

#import <ListrakSDK/ListrakOrder.h>
#import <ListrakSDK/ListrakOrdering.h>
#import <ListrakSDK/ListrakCart.h>
#import <ListrakSDK/ListrakSession.h>
#import <ListrakSDK/ListrakConfig.h>
#import "ListrakService.h"

SpecBegin(ListrakOrder)

describe(@"ListrakOrder", ^{
    __block ListrakService *mockService;

    before(^ {
        mockService = mock([ListrakService class]);
        [ListrakService setInstance:mockService];
    });

    describe(@"when ordering", ^{

        describe(@"creating order from cart", ^{
            __block ListrakOrder *order;

            beforeAll(^{
                [ListrakCart addItemWithSku:@"test-sku"
                                   quantity:1
                                      price:[NSDecimalNumber decimalNumberWithString:@"1.0"]
                                      title:@"test-title"
                                   imageUrl:nil
                                    linkUrl:nil];
                order = [ListrakOrdering createOrderFromCart];
            });

            it(@"should contain 1 item in order", ^{
               assertThatInteger((int) order.items.count, equalToInteger(1));
            });

            it(@"should contain ListrakItem for sku", ^{
                assertThat([order.items valueForKey:@"test-sku"], notNilValue());
            });

            describe(@"initializes empty or 0 values in Order", ^{

                it(@"for email address", ^{
                    assertThat(order.emailAddress, equalTo(@""));
                });

                it(@"for first name", ^{
                    assertThat(order.firstName, equalTo(@""));
                });

                it(@"for last name", ^{
                    assertThat(order.lastName, equalTo(@""));
                });

                it(@"for currency", ^{
                    assertThat(order.currency, equalTo(@""));
                });

                it(@"for orderNumber", ^{
                    assertThat(order.orderNumber, equalTo(@""));
                });

                it(@"for orderTotal", ^{
                    assertThatDouble(order.orderTotal.doubleValue, equalTo(@0));
                });

                it(@"for shippingTotal", ^{
                    assertThatDouble(order.shippingTotal.doubleValue, equalTo(@0));
                });

                it(@"for taxTotal", ^{
                    assertThatDouble(order.taxTotal.doubleValue, equalTo(@0));
                });

                it(@"for handlingTotal", ^{
                    assertThatDouble(order.handlingTotal.doubleValue, equalTo(@0));
                });
            });
        });

        describe(@"submitting order", ^{

            it(@"for nil order throws exception", ^{
                assertThat(^{
                    [ListrakOrdering submitOrder:nil];
                }, throwsException(hasProperty(@"name", NSInvalidArgumentException)));
            });

        });

    });

    describe(@"for an order", ^{
        __block ListrakOrder *order;

        beforeAll(^{
            order = [[ListrakOrder alloc] init];
        });

        describe(@"when adding an item", ^{

            it(@"with nil sku will throw an exception", ^{
                assertThat(^{
                    [order addItemWithSku:nil
                                 quantity:1
                                    price:[NSDecimalNumber decimalNumberWithString:@"1.0"]];
                }, throwsException(hasProperty(@"name", NSInvalidArgumentException)));
            });

            it(@"with 0 quantity will throw an exception", ^{
                assertThat(^{
                    [order addItemWithSku:@"test-sku-1"
                                 quantity:0
                                    price:[NSDecimalNumber decimalNumberWithString:@"1.0"]];
                }, throwsException(hasProperty(@"name", NSInvalidArgumentException)));
            });

        });

        describe(@"when setting a customer", ^{

            describe(@"with valid email, first name, and last name arguments", ^{

                beforeAll(^{
                    [order setCustomerWithEmailAddress:@"email" firstName:@"first" lastName:@"last"];
                });

                it(@"sets the order email", ^{
                    assertThat(order.emailAddress, equalTo(@"email"));
                });

                it(@"sets the order firstName", ^{
                    assertThat(order.firstName, equalTo(@"first"));
                });

                it(@"sets the order lastName", ^{
                    assertThat(order.lastName, equalTo(@"last"));
                });

            });

            it(@"with nil email throws exception", ^{
                assertThat(^{
                    [order setCustomerWithEmailAddress:nil firstName:nil lastName:nil];
                }, throwsException(hasProperty(@"name", NSInvalidArgumentException)));
            });

            describe(@"from ListrakSession", ^{

                beforeAll(^{
                    [ListrakConfig initializeWithClientTemplateId:@"test-template-id"
                                                 clientMerchantId:@"test-merchant-id"];
                    ListrakConfig.hostOverride = @"test-host";
                    ListrakConfig.useHttps = NO;
                    [ListrakSession startWithIdentityWithEmailAddress:@"test-email"
                                                            firstName:@"test-first-name"
                                                             lastName:@"test-last-name"];
                    [order setCustomerFromSession];
                });


                it(@"sets the order email", ^{
                    assertThat(order.emailAddress, equalTo(@"test-email"));
                });

                it(@"sets the order firstName", ^{
                    assertThat(order.firstName, equalTo(@"test-first-name"));
                });

                it(@"sets the order lastName", ^{
                    assertThat(order.lastName, equalTo(@"test-last-name"));
                });

            });

        });

    });

});

SpecEnd
