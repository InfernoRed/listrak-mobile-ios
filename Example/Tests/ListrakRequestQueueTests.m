//
//  ListrakRequestQueueTests.m
//  ListrakSDK
//
//  Created by Pamela Vong on 5/8/17.
//  Copyright © 2017 Listrak. All rights reserved.
//

// https://github.com/Specta/Specta

#import "ListrakRequestQueue.h"

SpecBegin(ListrakRequestQueue)

    describe(@"ListrakRequestQueue", ^{
        __block ListrakHttpService *mockHttpService;

        beforeAll(^ {
            mockHttpService = mock([ListrakHttpService class]);
            [ListrakHttpService setInstance:mockHttpService];
        });

        describe(@"enqueueRequestWithUrl", ^{

            xit(@"removes the url queue when request succeeds", ^{
                [givenVoid([mockHttpService sendRequest:anything()])
                        willDo: ^id (NSInvocation *invocation) {
                            [ListrakRequestQueue.sharedInstance requestCompleted:YES];
                            return nil;
                        }];
                NSUInteger startCount = ListrakRequestQueue.sharedInstance.urlQueue.count;
                [ListrakRequestQueue enqueueRequestWithUrl:[NSURL URLWithString:@"test-url"]];
                waitUntil(^(DoneCallback done) {
                    assertThatUnsignedInteger(ListrakRequestQueue.sharedInstance.urlQueue.count, equalToUnsignedInteger(startCount));
                    // Async example blocks need to invoke done() callback.
                    done();
                });
            });


            xit(@"contains urls in the queue when request fails", ^ {
                [givenVoid([mockHttpService sendRequest:anything()])
                        willDo: ^id (NSInvocation *invocation) {
                            [ListrakRequestQueue.sharedInstance requestCompleted:NO];
                            return nil;
                        }];
                ListrakRequestQueue.sharedInstance.maxAttempts = 3;
                [ListrakRequestQueue enqueueRequestWithUrl:[NSURL URLWithString:@"test-url-1"]];
                waitUntil(^(DoneCallback done) {
                    assertThatUnsignedInteger(ListrakRequestQueue.sharedInstance.urlQueue.count, greaterThanOrEqualTo(@1));
                    // Async example blocks need to invoke done() callback.
                    done();
                });
            });

        });

    });

SpecEnd
