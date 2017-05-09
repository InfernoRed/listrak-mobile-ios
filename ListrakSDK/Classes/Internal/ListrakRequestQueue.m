//
//  ListrakRequestQueue.m
//  ListrakSDK
//
//  Created by Pamela Vong on 5/7/17.
//
//

#import "ListrakRequestQueue.h"


static ListrakRequestQueue* singletonInstance;

@implementation ListrakRequestQueue

#pragma mark - Singleton Getter and Setter

+ (ListrakRequestQueue *)sharedInstance {
    if (singletonInstance == nil) {
        singletonInstance = [[ListrakRequestQueue alloc] init];
        singletonInstance.urlQueue = [NSMutableArray array];
        singletonInstance.isRunning = NO;
        ListrakHttpService.sharedInstance.delegate = singletonInstance;
    }
    return singletonInstance;
}

// for testing with mocks
+ (void)setInstance:(ListrakRequestQueue *)service {
    singletonInstance = service;
}

#pragma mark - Public Static Members

+ (void)enqueueRequestWithUrl:(NSURL *)url {
    [self.sharedInstance enqueueRequestWithUrl:url];
}

#pragma mark - Internal Instance Members

- (void)enqueueRequestWithUrl:(NSURL *)url {
    [_urlQueue addObject:url];
    if (_isRunning == NO) {
        _isRunning = YES;
        [self runBackgroundTask];
    }
}

- (void)runBackgroundTask {
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        [self attemptRequest];
    });
}

- (void)attemptRequest {
    if(_urlQueue != nil && _urlQueue.count > 0 && (_maxAttempts == 0 || _maxAttempts > _numberOfAttempts))
    {
        _numberOfAttempts++;
        [ListrakHttpService sendRequest:_urlQueue.firstObject];
    } else {
        // set not running when count of queue is 0
        _isRunning = NO;
    }
}

#pragma mark - Instance Delegate Members

- (void)requestCompleted:(BOOL)success {
    if (success) {
        // remove url from top of queue
        [_urlQueue removeObjectAtIndex:(NSUInteger) 0];
    } else {
        [NSThread sleepForTimeInterval:2]; //wait for finish
    }
    // call attemptRequest again
    [self attemptRequest];
}

@end