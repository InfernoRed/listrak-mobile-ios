//
//  ListrakConfig.h
//  ListrakSDK
//
//  Created by Pamela Vong on 5/6/17.
//
//

#import <Foundation/Foundation.h>

@interface ListrakConfig : NSObject

+ (void)initializeWithClientTemplateId:(NSString *)templateId
                       clientMerchantId:(NSString *)merchantId;
+ (BOOL)isInitialized;
+ (NSString *)appId;
+ (NSString *)visitId;
+ (NSString *)clientTemplateId;
+ (void)setClientTemplateId:(NSString *)templateId;
+ (NSString *)clientMerchantId;
+ (void)setClientMerchantId:(NSString *)merchantId;
+ (void)setHostOverride:(NSString *)hostOverride;
+ (void)setUseHttps:(BOOL)useHttps;

@end
