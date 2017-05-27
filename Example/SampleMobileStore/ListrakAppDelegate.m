//
//  ListrakAppDelegate.m
//  ListrakSDK
//
//  Created by Pamela Vong on 05/04/2017.
//  Copyright (c) 2017 Listrak. All rights reserved.
//

#import <ListrakSDK/ListrakConfig.h>
#import <ListrakSDK/ListrakSession.h>
#import "ListrakAppDelegate.h"
#import "Account.h"

@implementation ListrakAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    Account *account = Account.sharedInstance;

    // LISTRAK SDK
    // for testing purposes only
    //
    [ListrakConfig setHostOverride:@"localhost:9000"];
    [ListrakConfig setUseHttps:false];

    // LISTRAK SDK
    // initialize the sdk
    // if we're signed in, start a session with the current signed-in user
    // otherwise just start a new session
    //
    [ListrakConfig initializeWithClientTemplateId:@"123" clientMerchantId:@"456"];
    if (account.isSignedIn) {
        [ListrakSession startWithIdentityWithEmailAddress:account.email
                                                firstName:account.firstName
                                                 lastName:account.lastName];
    } else {
        [ListrakSession start];
    }

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
