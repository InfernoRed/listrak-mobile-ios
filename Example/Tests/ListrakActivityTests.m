//
//  ListrakActivityTests.m
//  ListrakSDKTests
//
//  Created by Pamela Vong on 05/04/2017.
//  Copyright (c) 2017 Listrak. All rights reserved.
//

// https://github.com/Specta/Specta

#import <ListrakSDK/ListrakActivity.h>

SpecBegin(ListrakActivity)

    describe(@"ListrakActivity", ^{

        describe(@"track product browse", ^{

            it(@"with nil sku will throw an exception", ^{
                assertThat(^{
                    [ListrakActivity trackProductBrowseWithSku:nil];
                }, throwsException(hasProperty(@"name", NSInvalidArgumentException)));
            });

        });


    });

SpecEnd