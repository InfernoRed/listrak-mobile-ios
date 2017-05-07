//
//  ListrakConfig.m
//  ListrakSDK
//
//  Created by Pamela Vong on 5/6/17.
//
//

#import "ListrakConfig.h"
#import "ListrakConfigExtension.h"

@implementation ListrakConfig

#pragma mark - Singleton Initialization

- (ListrakConfig *)init {
    self = [super init];
    if (self) {
        _isInitialized = NO;
        _clientTemplateId = @"";
        _clientMerchantId = @"";
        _appId = @"";
        _visitId = @"";
        _hostOverride = @"";
        _useHttps = YES;
    }
    return self;
}

+ (ListrakConfig *)sharedInstance {
    static ListrakConfig *myInstance = nil;
    if (myInstance == nil) {
        myInstance = [[[self class] alloc] init];
    }
    return myInstance;
}

#pragma mark - Public Static Members

/// Statically initialize the singleton Config instance with a template id and merchant id
/// @param templateId
/// @param merchantId
+ (void)initializeWithClientTemplateId:(NSString *)templateId
                      clientMerchantId:(NSString *)merchantId {
    [self.sharedInstance initializeWithClientTemplateId:templateId
                                       clientMerchantId:merchantId];
}

/// Check if the ListrakConfig initialized
/// @return
+ (BOOL)isInitialized {
    return self.sharedInstance.isInitialized;
}

/// Gets the current app id's UUID string stored in the user's local storage
/// @return
+ (NSString *)appId {
    return self.sharedInstance.appId;
}

/// Gets the current visit id's UUID string
/// @return
+ (NSString *)visitId {
    return self.sharedInstance.visitId;
}

/// Gets the current app's Listrak client template id
/// @return
+ (NSString *)clientTemplateId {
    return self.sharedInstance.clientTemplateId;
}

/// Gets the current app's Listrak client merchant id
/// @return
+ (NSString *)clientMerchantId {
    return self.sharedInstance.clientMerchantId;
}

#pragma mark - Internal Static Members

+ (NSString *)hostOverride {
    return self.sharedInstance.hostOverride;
}

+ (BOOL)useHttps {
    return self.sharedInstance.useHttps;
}

+ (void)ensureInitialized {
    if (![ListrakConfig isInitialized]) {
        [NSException raise:NSGenericException format:@"Config has not been initialized yet. "
                "To initialize call [ListrakConfig initializeWithClientTemplateId:(NSString *)templateId clientMerchantId:(NSString *)merchantId]."];
    }
}

#pragma mark - Internal Instance Members

- (void)initializeWithClientTemplateId:(NSString *)templateId
                      clientMerchantId:(NSString *)merchantId {
    _clientTemplateId = templateId;
    _clientMerchantId = merchantId;
    _appId = [self getAppIdFromStorage];
    _visitId = [[NSUUID UUID] UUIDString];
    _isInitialized = true;
}

- (BOOL)isInitialized {
    return _isInitialized;
}

- (NSString *)appId {
    return _appId;
}

- (NSString *)visitId {
    return _visitId;
}

- (NSString *)clientTemplateId {
    return _clientTemplateId;
}

- (NSString *)clientMerchantId {
    return _clientMerchantId;
}

- (NSString *)hostOverride {
    return _hostOverride;
}

- (BOOL)useHttps {
    return _useHttps;
}

#pragma mark - Private Members

- (NSString *)getAppIdFromStorage {
    NSString *storedAppId = [[NSUserDefaults standardUserDefaults] stringForKey:@"ListrakAppId"];
    if (storedAppId.length == 0) {
        storedAppId = [[NSUUID UUID] UUIDString];
        [[NSUserDefaults standardUserDefaults] setValue:storedAppId forKey:@"ListrakAppId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return storedAppId;
}

@end
