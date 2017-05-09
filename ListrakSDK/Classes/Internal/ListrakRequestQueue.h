//
//  ListrakRequestQueue.h
//  ListrakSDK
//
//  Created by Pamela Vong on 5/7/17.
//
//

#import <Foundation/Foundation.h>
#import "ListrakHttpService.h"


@interface ListrakRequestQueue : NSObject<ListrakHttpServiceDelegate>

@property (nonatomic, strong) NSMutableArray *urlQueue;
@property (nonatomic) BOOL isRunning;
@property (nonatomic) int numberOfAttempts; // For testing purposes, count the number of attempts
@property (nonatomic) int maxAttempts; // For testing purposes, when maxAttempts is 0, the number of request attempts is unlimited

+ (ListrakRequestQueue *)sharedInstance;
+ (void)setInstance:(ListrakRequestQueue *)listrakRequestQueue;
+ (void)enqueueRequestWithUrl:(NSURL *)url;

- (void)enqueueRequestWithUrl:(NSURL *)url;

@end