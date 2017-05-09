//
//  ListrakConfig.m
//  ListrakSDK
//
//  Created by Pamela Vong on 5/6/17.
//
//

#import "ListrakConfig.h"
#import "ListrakConfigExtension.h"
#import "ListrakContext.h"

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
/// @param templateId Listrak client template id
/// @param merchantId Listrak client merchant id
+ (void)initializeWithClientTemplateId:(NSString *)templateId
                      clientMerchantId:(NSString *)merchantId {
    [self.sharedInstance initializeWithClientTemplateId:templateId
                                       clientMerchantId:merchantId];
}

/// Check if the ListrakConfig initialized
/// @return BOOL indicating if initalized
+ (BOOL)isInitialized {
    return self.sharedInstance.isInitialized;
}

/// Gets the current app id's UUID string stored in the user's local storage
/// @return NSString of current app id
+ (NSString *)appId {
    return self.sharedInstance.appId;
}

/// Gets the current visit id's UUID string
/// @return NSString of current visit id
+ (NSString *)visitId {
    return self.sharedInstance.visitId;
}

/// Gets the current app's Listrak client template id
/// @return NSString of client template id
+ (NSString *)clientTemplateId {
    return self.sharedInstance.clientTemplateId;
}

/// Sets the client template id used by listrak
/// @param templateId the listrak template id
+ (void)setClientTemplateId:(NSString *)templateId {
    self.sharedInstance.clientTemplateId = templateId;
}

/// Gets the current app's Listrak client merchant id
/// @return NSString of client merchant id
+ (NSString *)clientMerchantId {
    return self.sharedInstance.clientMerchantId;
}

/// Sets the client merchant id used by Listrak
/// @param merchantId the listrak merchant id
+ (void)setClientMerchantId:(NSString *)merchantId {
    self.sharedInstance.clientMerchantId = merchantId;
}

/// Sets the host override value
/// @param hostOverride value to use as host for the listrak api
+ (void)setHostOverride:(NSString *)hostOverride {
    self.sharedInstance.hostOverride = hostOverride;
}

/// Sets the current apps use https indicator
/// @param useHttps indicates to use https
+ (void)setUseHttps:(BOOL)useHttps {
    self.sharedInstance.useHttps = useHttps;
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
    [ListrakContext initTimestamp];
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

- (void)setClientTemplateId:(NSString *)templateId {
    _clientTemplateId = templateId;
}

- (NSString *)clientMerchantId {
    return _clientMerchantId;
}

- (void)setClientMerchantId:(NSString *)merchantId {
    _clientMerchantId = merchantId;
}

- (NSString *)hostOverride {
    return _hostOverride;
}
- (void)setHostOverride:(NSString *)hostOverride {
    _hostOverride = hostOverride;
}

- (BOOL)useHttps {
    return _useHttps;
}

- (void)setUseHttps:(BOOL)useHttps {
    _useHttps = useHttps;
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
