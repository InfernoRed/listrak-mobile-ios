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
+ (NSString *)clientMerchantId;

@end
