//
//  ListrakService.m
//  ListrakSDK
//
//  Created by Pamela Vong on 5/8/17.
//
//

#import "ListrakService.h"
#import "ListrakOrder.h"
#import "ListrakContext.h"
#import "ListrakRequestQueue.h"
#import "ListrakCartItem.h"
#import "ListrakCartItemExtension.h"

static ListrakService* singletonInstance;

@implementation ListrakService

#pragma mark - Singleton Getter and Setter

+ (ListrakService *)getInstance {
    if (singletonInstance == nil) {
        singletonInstance = [[ListrakService alloc] init];
    }
    return singletonInstance;
}

// for testing with mocks
+ (void)setInstance:(ListrakService *)service {
    singletonInstance = service;
}

#pragma mark - Public Static Members

+ (void)trackProductBrowseWithSku:(NSArray *)skus {
    [self.getInstance trackProductBrowseWithSku:skus];
}

+ (void)captureCustomerWithEmail:(NSString *)email {
    [self.getInstance captureCustomerWithEmail:email];
}

+ (void)clearCart {
    [self.getInstance clearCart];
}

+ (void)updateCartWithCartItems:(NSArray *)cartItems {
    [self.getInstance updateCartWithCartItems:cartItems];
}

+ (void)submitOrder:(ListrakOrder *)order {
    [self.getInstance submitOrder:order];
}

+ (void)finalizeCartWithOrderNumber:(NSString *)orderNumber
                       emailAddress:(NSString *)email
                          firstName:(NSString *)firstName
                           lastName:(NSString *)lastName {
    [self.getInstance finalizeCartWithOrderNumber:orderNumber
                                     emailAddress:email
                                        firstName:firstName
                                         lastName:lastName];
}

+ (void)subscribeCustomerWithSubscriberCode:(NSString *)code
                               emailAddress:(NSString *)email
                                       meta:(NSDictionary *)meta {
    [self.getInstance subscribeCustomerWithSubscriberCode:code
                                             emailAddress:email
                                                     meta:meta];
}

#pragma mark - Private Instance Members

- (void)trackProductBrowseWithSku:(NSArray *)skus {
    [self verifyArgumentWithObject:skus name:@"skus"];

    [ListrakContext validate];

    NSMutableDictionary *queryDictionary = [@{
            @"vuid": ListrakContext.visitId,
            @"uid": [ListrakContext generateUid],
            @"gsid": ListrakContext.globalSessionId,
            @"sid": ListrakContext.sessionId
    } mutableCopy];

    int index = 0;
    for (NSString *sku in skus) {
        queryDictionary[[NSString stringWithFormat:@"_t_%i", index]] = @"at";
        queryDictionary[[NSString stringWithFormat:@"t_%i", index]] = @"ProductBrowse";
        queryDictionary[[NSString stringWithFormat:@"k_%i", index]] = sku;
        index++;
    }

    NSString *trackProductBrowseHost = @"at1.listrakbi.com";
    NSString *trackProductBrowsePath = [NSString stringWithFormat:@"/activity/%@", ListrakContext.merchantId];

    [self sendFormattedRequestWithHost:trackProductBrowseHost
                                  path:trackProductBrowsePath
                           queryParams:queryDictionary];
}

- (void)captureCustomerWithEmail:(NSString *)email {
    [self verifyArgumentWithString:email name:@"email"];

    [ListrakContext validate];

    NSDictionary *queryDictionary = @{
            @"_tid": ListrakContext.templateId,
            @"_uid": [ListrakContext generateUid],
            @"gsid": ListrakContext.globalSessionId,
            @"_sid": ListrakContext.sessionId,
            @"_t": [[NSNumber numberWithLong:ListrakContext.unixTimestamp] stringValue],
            @"email": email
    };

    NSString *captureCustomerHost = @"sca1.listrakbi.com";
    NSString *captureCustomerPath = @"/Handlers/Update.ashx";

    [self sendFormattedRequestWithHost:captureCustomerHost
                                  path:captureCustomerPath
                           queryParams:queryDictionary];
}

- (void)clearCart {
    [ListrakContext validate];

    NSDictionary *queryDictionary = @{
            @"_tid": ListrakContext.templateId,
            @"_uid": [ListrakContext generateUid],
            @"gsid": ListrakContext.globalSessionId,
            @"_sid": ListrakContext.sessionId,
            @"cc": @"true"
    };

    NSString *clearCartHost = @"sca1.listrakbi.com";
    NSString *clearCartPath = @"/Handlers/Set.ashx";

    [self sendFormattedRequestWithHost:clearCartHost
                                  path:clearCartPath
                           queryParams:queryDictionary];
}

- (void)updateCartWithCartItems:(NSArray *)cartItems {

    [ListrakContext validate];

    NSMutableDictionary *queryDictionary = [@{
            @"_tid": ListrakContext.templateId,
            @"_uid": [ListrakContext generateUid],
            @"gsid": ListrakContext.globalSessionId,
            @"_sid": ListrakContext.sessionId,
    } mutableCopy];

    int index = 0;
    for (ListrakCartItem *item in cartItems) {
        queryDictionary[[NSString stringWithFormat:@"s_%i", index]] = item.sku;
        queryDictionary[[NSString stringWithFormat:@"q_%i", index]] = [[NSNumber numberWithInteger:item.quantity] stringValue];
        queryDictionary[[NSString stringWithFormat:@"p_%i", index]] = [item.price stringValue];
        queryDictionary[[NSString stringWithFormat:@"n_%i", index]] = item.title;
        queryDictionary[[NSString stringWithFormat:@"iu_%i", index]] = item.imageUrl;
        queryDictionary[[NSString stringWithFormat:@"lu_%i", index]] = item.linkUrl;
        index++;
    }

    NSString *updateCartHost = @"sca1.listrakbi.com";
    NSString *updateCartPath = @"/Handlers/Set.ashx";

    [self sendFormattedRequestWithHost:updateCartHost
                                  path:updateCartPath
                           queryParams:queryDictionary];
}

- (void)submitOrder:(ListrakOrder *)order {
    [self verifyArgumentWithObject:order name:@"order"];

    [ListrakContext validate];

    NSMutableDictionary *queryDictionary = [@{
            @"ctid": ListrakContext.merchantId,
            @"uid": [ListrakContext generateUid],
            @"gsid": ListrakContext.globalSessionId,

            @"on": order.orderNumber,
            @"_t_0": @"o",
            @"ot_0": [order.orderTotal stringValue],
            @"tt_0": [order.taxTotal stringValue],
            @"st_0": [order.shippingTotal stringValue],
            @"ht_0": [order.handlingTotal stringValue],
            @"it_0": [[NSNumber numberWithInteger:order.items.count] stringValue],
            @"_t_1": @"tt",
            @"e_1": @"t",
            @"_t_2": @"c",
            @"e_2": order.emailAddress,
            @"_t_3": @"i"
    } mutableCopy];

    if (!(order.firstName.length == 0)) queryDictionary[@"fn_2"] = order.firstName;
    if (!(order.lastName.length == 0)) queryDictionary[@"ln_2"] = order.lastName;

    NSString *submitOrderHost = @"s1.listrakbi.com";
    NSString *submitOrderPath = @"/t/T.ashx";

    [self sendFormattedRequestWithHost:submitOrderHost
                                  path:submitOrderPath
                           queryParams:queryDictionary];
}

- (void)finalizeCartWithOrderNumber:(NSString *)orderNumber
                       emailAddress:(NSString *)email
                          firstName:(NSString *)firstName
                           lastName:(NSString *)lastName {
    [self verifyArgumentWithString:orderNumber name:@"orderNumber"];
    [self verifyArgumentWithString:email name:@"email"];

    [ListrakContext validate];

    NSMutableDictionary *queryDictionary = [@{
            @"_tid": ListrakContext.templateId,
            @"_uid": [ListrakContext generateUid],
            @"gsid": ListrakContext.globalSessionId,
            @"_sid": ListrakContext.sessionId,
            @"on": orderNumber,
            @"e": email
    } mutableCopy];

    if (!(firstName.length == 0)) queryDictionary[@"fn"] = firstName;
    if (!(lastName.length == 0)) queryDictionary[@"ln"] = lastName;

    NSString *finalizeCartHost = @"sca1.listrakbi.com";
    NSString *finalizeCartPath = @"/Handlers/Set.ashx";

    [self sendFormattedRequestWithHost:finalizeCartHost
                                  path:finalizeCartPath
                           queryParams:queryDictionary];
}

- (void)subscribeCustomerWithSubscriberCode:(NSString *)code
                               emailAddress:(NSString *)email
                                       meta:(NSDictionary *)meta {
    [self verifyArgumentWithString:code name:@"subscriberCode"];
    [self verifyArgumentWithString:email name:@"email"];

    [ListrakContext validate];

    NSMutableDictionary *queryDictionary = [@{
            @"ctid": ListrakContext.merchantId,
            @"uid": [ListrakContext generateUid],
            @"_t_0": @"s",
            @"e_0": email,
            @"l_0": code
    } mutableCopy];

    for (NSString *key in meta) {
        queryDictionary[[NSString stringWithFormat:@"%@_0", key]] = meta[key];
    }

    NSString *subscribeCustomerHost = @"s1.listrakbi.com";
    NSString *subscribeCustomerPath = @"/t/S.ashx";

    [self sendFormattedRequestWithHost:subscribeCustomerHost
                                  path:subscribeCustomerPath
                           queryParams:queryDictionary];
}

- (void)verifyArgumentWithObject:(NSObject *)arg name:(NSString *)argName {
    if (arg == nil) {
        [NSException raise:NSInvalidArgumentException format:@"%@ cannot be null", argName];
    }
}

- (void)verifyArgumentWithString:(NSString *)arg name:(NSString *)argName {
    if (arg.length == 0) {
        [NSException raise:NSInvalidArgumentException format:@"%@ cannot be null or empty", argName];
    }
}

- (void)sendFormattedRequestWithHost:(NSString *)host
                                      path:(NSString *)path
                               queryParams:(NSDictionary *)params {
    NSURLComponents *components = [[NSURLComponents alloc] init];
    components.scheme = ListrakContext.useHttps ? @"https" : @"http";
    if (ListrakContext.hostOverride.length == 0) {
        components.host = host;
    } else {
        NSArray<NSString *> *hostOverrideSubstrings = [ListrakContext.hostOverride componentsSeparatedByString:@":"];
        components.host = hostOverrideSubstrings[0];
        components.port = [NSNumber numberWithInteger:[hostOverrideSubstrings[1] integerValue]];
    }
    components.path = path;
    NSMutableArray *queryItems = [NSMutableArray array];
    for (NSString *key in params) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:[self urlEncodingValue:key]
                                                          value:[self urlEncodingValue:params[key]]]];
    }
    components.queryItems = queryItems;

    [ListrakRequestQueue enqueueRequestWithUrl:components.URL];
}

- (NSString *)urlEncodingValue:(NSString *)value
{
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSMutableCharacterSet *mutableQueryAllowedCharacterSet = [set mutableCopy];
    [mutableQueryAllowedCharacterSet removeCharactersInString:@"!*'();:@&=+$,/?%#[]"];
    return [value stringByAddingPercentEncodingWithAllowedCharacters:mutableQueryAllowedCharacterSet];
}

@end
