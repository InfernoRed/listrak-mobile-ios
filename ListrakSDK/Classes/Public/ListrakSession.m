//
//  ListrakSession.m
//  ListrakSDK
//
//  Created by Pamela Vong on 5/6/17.
//
//

#import "ListrakSession.h"
#import "ListrakSessionExtension.h"
#import "ListrakConfig.h"
#import "ListrakConfigExtension.h"
#import "ListrakService.h"

@implementation ListrakSession

#pragma mark - Singleton Initialization

- (ListrakSession *)init {
    self = [super init];
    if (self) {
        _isStarted = NO;
        _hasIdentity = NO;
        _sessionId = @"";
        _emailAddress = @"";
        _firstName = @"";
        _lastName = @"";
    }
    return self;
}

+ (ListrakSession *)sharedInstance {
    static ListrakSession *myInstance = nil;
    if (myInstance == nil) {
        myInstance = [[[self class] alloc] init];
    }
    return myInstance;
}

#pragma mark - Public Static Members

+ (BOOL)isStarted {
    return self.sharedInstance.isStarted;
}

+ (BOOL)hasIdentity {
    return self.sharedInstance.hasIdentity;
}

+ (NSString *)sessionId {
    return self.sharedInstance.sessionId;
}

+ (NSString *)emailAddress {
    return self.sharedInstance.emailAddress;
}

+ (NSString *)firstName {
    return self.sharedInstance.firstName;
}

+ (NSString *)lastName {
    return self.sharedInstance.lastName;
}

+ (void)start {
    [self.sharedInstance start];
}

+ (void)startWithIdentityWithEmailAddress:(NSString *)email
                                firstName:(NSString *)firstName
                                 lastName:(NSString *)lastName {
    [self.sharedInstance startWithIdentityWithEmailAddress:email
                                                 firstName:firstName
                                                  lastName:lastName];
}

+ (void)setIdentityWithEmailAddress:(NSString *)email
                          firstName:(NSString *)firstName
                           lastName:(NSString *)lastName {
    [self.sharedInstance setIdentityWithEmailAddress:email
                                           firstName:firstName
                                            lastName:lastName];
}

+ (void)subscribeWithSubscriberCode:(NSString *)code
                               meta:(NSDictionary *)meta {
    [self.sharedInstance subscribeWithSubscriberCode:code meta:meta];
}

#pragma mark - Internal Instance Members

- (BOOL)isStarted {
    return _isStarted;
}

- (BOOL)hasIdentity {
    return _hasIdentity;
}

- (NSString *)sessionId {
    return _sessionId;
}

- (NSString *)emailAddress {
    return _emailAddress;
}

- (NSString *)firstName {
    return _firstName;
}

- (NSString *)lastName {
    return _lastName;
}

#pragma mark - Internal Static Members

+ (void)ensureStarted {
    [ListrakConfig ensureInitialized];

    if (!self.isStarted) {
        [NSException raise:NSGenericException format:@"session has not been started yet"];
    }
}

+ (void)reset {
    [self.sharedInstance reset];
}

#pragma mark - Private Members

- (void)start {
    [ListrakConfig ensureInitialized];

    _isStarted = YES;
    _hasIdentity = NO;
    _sessionId = [[NSUUID UUID] UUIDString];
    _emailAddress = @"";
    _firstName = @"";
    _lastName = @"";
}

- (void)startWithIdentityWithEmailAddress:(NSString *)email
        firstName:(NSString *)firstName
        lastName:(NSString *)lastName {
    [ListrakConfig ensureInitialized];

    if (email.length == 0) {
        [NSException raise:NSInvalidArgumentException format:@"emailAddress cannot be null or empty"];
    }

    [self start];
    [self setIdentityWithEmailAddress:email
                            firstName:firstName
                             lastName:lastName];
}

- (void)setIdentityWithEmailAddress:(NSString *)email
        firstName:(NSString *)firstName
        lastName:(NSString *)lastName {
    if (email.length == 0) {
        [NSException raise:NSInvalidArgumentException format:@"emailAddress cannot be null or empty"];
    }
    if (!_isStarted) {
        [NSException raise:NSGenericException format:@"session has not been started yet"];
    }

    _emailAddress = email;
    _firstName = firstName;
    _lastName = lastName;
    _hasIdentity = YES;

    [ListrakService captureCustomerWithEmail:email];
}

- (void)subscribeWithSubscriberCode:(NSString *)code
                               meta:(NSDictionary *)meta {
    if (code.length == 0) {
        [NSException raise:NSInvalidArgumentException format:@"code cannot be null or empty"];
    }
    if (!_isStarted) {
        [NSException raise:NSGenericException format:@"session has not been started yet"];
    }
    if (!_hasIdentity) {
        [NSException raise:NSGenericException format:@"session identity has not been set yet"];
    }

    if (meta == nil) {
        meta = [NSDictionary dictionary];
    }

    [ListrakService subscribeCustomerWithSubscriberCode:code
                                           emailAddress:_emailAddress
                                                   meta:meta];
}

- (void)reset {
    _sessionId = [[NSUUID UUID] UUIDString];
}

@end
