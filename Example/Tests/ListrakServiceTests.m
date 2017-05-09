//
//  ListrakServiceTests.m
//  ListrakSDK
//
//  Created by Pamela Vong on 5/8/17.
//  Copyright © 2017 Listrak. All rights reserved.
//

// https://github.com/Specta/Specta

#import <ListrakSDK/ListrakConfig.h>
#import <ListrakSDK/ListrakSession.h>
#import <ListrakSDK/ListrakCartItem.h>
#import <ListrakSDK/ListrakOrdering.h>
#import <ListrakSDK/ListrakOrder.h>
#import "ListrakCartItemExtension.h"
#import "ListrakRequestQueue.h"
#import "ListrakService.h"

SpecBegin(ListrakService)

describe(@"ListrakService", ^{
    __block ListrakRequestQueue <ListrakHttpServiceDelegate> *mockRequestQueue;

    beforeAll(^ {
        [ListrakService setInstance:[[ListrakService alloc] init]];
        mockRequestQueue = mockObjectAndProtocol([ListrakRequestQueue class], @protocol(ListrakHttpServiceDelegate));
        [ListrakRequestQueue setInstance:mockRequestQueue];
        [givenVoid([mockRequestQueue enqueueRequestWithUrl:anything()])
                willDo: ^id (NSInvocation *invocation) {
                    return nil;
                }];

        [ListrakConfig initializeWithClientTemplateId:@"test-template-id"
                                     clientMerchantId:@"test-merchant-id"];
        ListrakConfig.hostOverride = @"test-host";
        ListrakConfig.useHttps = NO;
        [ListrakSession startWithIdentityWithEmailAddress:@"test-email"
                                                firstName:@"test-first-name"
                                                 lastName:@"test-last-name"];
    });

    describe(@"trackProductBrowseWithSku with formatted url", ^{
        __block HCArgumentCaptor *argument;

        beforeAll(^{
            [ListrakService trackProductBrowseWithSku:[NSArray arrayWithObjects:@"test-sku", nil]];
            argument = [[HCArgumentCaptor alloc] init];
            [verifyCount(mockRequestQueue, atLeastOnce()) enqueueRequestWithUrl:(NSURL *)argument];
        });

        it(@"host is the test-host", ^{
            assertThat([(NSURL *)argument.value host], is(@"test-host"));
        });

        it(@"scheme is http", ^{
            assertThat([(NSURL *)argument.value scheme], is(@"http"));
        });

        it(@"path contains /activity/", ^{
            assertThat([(NSURL *)argument.value path], containsSubstring(@"/activity/"));
        });

        it(@"path contains merchant-id", ^{
            assertThat([(NSURL *)argument.value path], containsSubstring(ListrakConfig.clientMerchantId));
        });

        it(@"query contains k_0=test-sku", ^{
            assertThat([(NSURL *)argument.value query], containsSubstring(@"k_0=test-sku"));
        });
    });

    describe(@"captureCustomerWithEmail with formatted url", ^{
        __block HCArgumentCaptor *argument;

        beforeAll(^{
            [ListrakService captureCustomerWithEmail:@"test-email"];
            argument = [[HCArgumentCaptor alloc] init];
            [verifyCount(mockRequestQueue, atLeastOnce()) enqueueRequestWithUrl:(NSURL *)argument];
        });

        it(@"path contains /Handlers/Update.ashx", ^{
            assertThat([(NSURL *)argument.value path], containsSubstring(@"/Handlers/Update.ashx"));
        });

        it(@"query contains email=test-email", ^{
            assertThat([(NSURL *)argument.value query], containsSubstring(@"email=test-email"));
        });
    });

    describe(@"clearCart with formatted url", ^{
        __block HCArgumentCaptor *argument;

        beforeAll(^{
            [ListrakService clearCart];
            argument = [[HCArgumentCaptor alloc] init];
            [verifyCount(mockRequestQueue, atLeastOnce()) enqueueRequestWithUrl:(NSURL *)argument];
        });

        it(@"path contains /Handlers/Set.ashx", ^{
            assertThat([(NSURL *)argument.value path], containsSubstring(@"/Handlers/Set.ashx"));
        });

        it(@"query contains _tid=test-template-id", ^{
            assertThat([(NSURL *)argument.value query], containsSubstring(@"_tid=test-template-id"));
        });
    });

    describe(@"updateCart with formatted url", ^{
        __block HCArgumentCaptor *argument;

        beforeAll(^{
            ListrakCartItem *cartItem = [[ListrakCartItem alloc] initWithSku:@"test-sku"
                                                                    quantity:(long)1
                                                                       price:[NSDecimalNumber zero]
                                                                       title:@"test-title"
                                                                    imageUrl:@""
                                                                     linkUrl:@""];
            [ListrakService updateCartWithCartItems:[NSArray arrayWithObjects:cartItem, nil]];
            argument = [[HCArgumentCaptor alloc] init];
            [verifyCount(mockRequestQueue, atLeastOnce()) enqueueRequestWithUrl:(NSURL *)argument];
        });

        it(@"path contains /Handlers/Set.ashx", ^{
            assertThat([(NSURL *)argument.value path], containsSubstring(@"/Handlers/Set.ashx"));
        });

        it(@"query contains s_0=test-sku", ^{
            assertThat([(NSURL *)argument.value query], containsSubstring(@"s_0=test-sku"));
        });
    });

    describe(@"updateCart with formatted url", ^{
        __block HCArgumentCaptor *argument;

        beforeAll(^{
            ListrakOrder *order = [ListrakOrdering createOrder];
            order.orderNumber = @"test-order-number";
            [ListrakService submitOrder:order];
            argument = [[HCArgumentCaptor alloc] init];
            [verifyCount(mockRequestQueue, atLeastOnce()) enqueueRequestWithUrl:(NSURL *)argument];
        });

        it(@"path contains /t/T.ashx", ^{
            assertThat([(NSURL *)argument.value path], containsSubstring(@"/t/T.ashx"));
        });

        it(@"query contains on=test-order-number", ^{
            assertThat([(NSURL *)argument.value query], containsSubstring(@"on=test-order-number"));
        });
    });

    describe(@"finalizeCart with formatted url", ^{
        __block HCArgumentCaptor *argument;

        beforeAll(^{
            [ListrakService finalizeCartWithOrderNumber:@"order-number"
                                           emailAddress:@"email-test"
                                              firstName:@""
                                               lastName:@""];
            argument = [[HCArgumentCaptor alloc] init];
            [verifyCount(mockRequestQueue, atLeastOnce()) enqueueRequestWithUrl:(NSURL *)argument];
        });

        it(@"path contains /Handlers/Set.ashx", ^{
            assertThat([(NSURL *)argument.value path], containsSubstring(@"/Handlers/Set.ashx"));
        });

        it(@"query contains on=order-number", ^{
            assertThat([(NSURL *)argument.value query], containsSubstring(@"on=order-number"));
        });
    });

    describe(@"subscribeCustomer with formatted url", ^{
        __block HCArgumentCaptor *argument;

        beforeAll(^{
            [ListrakService subscribeCustomerWithSubscriberCode:@"test-code"
                                                   emailAddress:@"test-email"
                                                           meta:@{@"test-key":@"test-value"}];
            argument = [[HCArgumentCaptor alloc] init];
            [verifyCount(mockRequestQueue, atLeastOnce()) enqueueRequestWithUrl:(NSURL *)argument];
        });

        it(@"path contains /t/S.ashx", ^{
            assertThat([(NSURL *)argument.value path], containsSubstring(@"/t/S.ashx"));
        });

        it(@"query contains test-key_0=test-value", ^{
            assertThat([(NSURL *)argument.value query], containsSubstring(@"test-key_0=test-value"));
        });
    });
});

SpecEnd
