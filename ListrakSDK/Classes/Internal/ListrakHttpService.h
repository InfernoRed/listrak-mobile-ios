//
//  ListrakHttpService.h
//  ListrakSDK
//
//  Created by Pamela Vong on 5/8/17.
//
//

#import <Foundation/Foundation.h>

@class ListrakHttpService;

@protocol ListrakHttpServiceDelegate <NSObject>
@required
- (void)requestCompleted:(BOOL)success;
@end

@interface ListrakHttpService : NSObject

@property (nonatomic, strong) id <ListrakHttpServiceDelegate> delegate;


+ (ListrakHttpService *)sharedInstance;
+ (void)setInstance:(ListrakHttpService *)service;
+ (void)sendRequest:(NSURL *)url;

- (void)sendRequest:(NSURL *)url;

@end
