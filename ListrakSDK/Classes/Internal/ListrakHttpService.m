//
//  ListrakHttpService.m
//  ListrakSDK
//
//  Created by Pamela Vong on 5/8/17.
//
//

#import "ListrakHttpService.h"

static ListrakHttpService* singletonInstance;

@implementation ListrakHttpService

#pragma mark - Singleton Getter and Setter

+ (ListrakHttpService *)sharedInstance {
    if (singletonInstance == nil) {
        singletonInstance = [[ListrakHttpService alloc] init];
    }
    return singletonInstance;
}

// for testing with mocks
+ (void)setInstance:(ListrakHttpService *)service {
    singletonInstance = service;
}


#pragma mark - Public Static Members

+ (void)sendRequest:(NSURL *)url {
    [self.sharedInstance sendRequest:url];
}

#pragma mark - Private Instance Members

- (void)sendRequest:(NSURL *)url {
    NSURLSessionDataTask *dataTask =
            [[NSURLSession sharedSession] dataTaskWithURL:url
                                        completionHandler:^(NSData *data,
                                                 NSURLResponse *response,
                                                 NSError *error) {
                                            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                            NSLog(@"response status code: %ld", (long)[httpResponse statusCode]);
                                            if (error != nil || httpResponse.statusCode > 400) {
                                                [self.delegate requestCompleted:NO];
                                            } else {
                                                [self.delegate requestCompleted:YES];
                                            }
                                         }];
    [dataTask resume];
}

@end
