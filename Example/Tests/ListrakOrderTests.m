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

SpecBegin(ListrakOrder)

describe(@"ListrakOrder", ^{

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
               expect(order.items.count).to.equal(1);
            });

            it(@"should contain ListrakItem for sku", ^{
                expect([order.items valueForKey:@"test-sku"]).notTo.beNil();
            });

            describe(@"initializes empty or 0 values in Order", ^{

                it(@"for email address", ^{
                    expect(order.emailAddress).to.equal(@"");
                });

                it(@"for first name", ^{
                    expect(order.firstName).to.equal(@"");
                });

                it(@"for last name", ^{
                    expect(order.lastName).to.equal(@"");
                });

                it(@"for currency", ^{
                    expect(order.currency).to.equal(@"");
                });

                it(@"for orderNumber", ^{
                    expect(order.orderNumber).to.equal(@"");
                });

                it(@"for orderTotal", ^{
                    expect(order.orderTotal).to.equal(@0);
                });

                it(@"for shippingTotal", ^{
                    expect(order.shippingTotal).to.equal(@0);
                });

                it(@"for taxTotal", ^{
                    expect(order.taxTotal).to.equal(@0);
                });

                it(@"for handlingTotal", ^{
                    expect(order.handlingTotal).to.equal(@0);
                });
            });
        });

        describe(@"submitting order", ^{

            it(@"for nil order throws exception", ^{
                expect(^{
                    [ListrakOrdering submitOrder:nil];
                }).to.raise(NSInvalidArgumentException);
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
                expect(^{
                  [order addItemWithSku:nil quantity:1 price:@1.0];
                }).to.raise(NSInvalidArgumentException);
            });

            it(@"with 0 quantity will throw an exception", ^{
                expect(^{
                    [order addItemWithSku:@"test-sku-1" quantity:0 price:@1.0];
                }).to.raise(NSInvalidArgumentException);
            });

        });

        describe(@"when setting a customer", ^{

            describe(@"with valid email, first name, and last name arguments", ^{

                beforeAll(^{
                    [order setCustomerWithEmailAddress:@"email" firstName:@"first" lastName:@"last"];
                });

                it(@"sets the order email", ^{
                    expect(order.emailAddress).to.equal(@"email");
                });

                it(@"sets the order firstName", ^{
                    expect(order.firstName).to.equal(@"first");
                });

                it(@"sets the order lastName", ^{
                    expect(order.lastName).to.equal(@"last");
                });

            });

            it(@"with nil email throws exception", ^{
                expect(^{
                    [order setCustomerWithEmailAddress:nil firstName:nil lastName:nil];
                }).to.raise(NSInvalidArgumentException);
            });

            describe(@"from ListrakSession", ^{
                // TODO: test session email, first name, last name
            });

        });

    });

});

SpecEnd