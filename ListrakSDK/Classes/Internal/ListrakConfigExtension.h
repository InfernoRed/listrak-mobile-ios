//
//  ListrakConfigExtension.h
//  ListrakSDK
//
//  Created by Pamela Vong on 5/7/17.
//
//

#import <Foundation/Foundation.h>

@interface ListrakConfig () {
    BOOL _isInitialized;
    NSString *_appId;
    NSString *_visitId;
    NSString *_clientTemplateId;
    NSString *_clientMerchantId;
    NSString *_hostOverride;
    BOOL _useHttps;
}

- (BOOL)isInitialized;
- (NSString *)appId;
- (NSString *)visitId;
- (NSString *)clientTemplateId;
- (NSString *)clientMerchantId;
- (NSString *)hostOverride;
- (BOOL)useHttps;

+ (NSString *)hostOverride;
+ (BOOL)useHttps;
+ (void)ensureInitialized;

@end
