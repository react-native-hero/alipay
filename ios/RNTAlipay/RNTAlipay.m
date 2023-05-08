#import "RNTAlipay.h"
#import <UIKit/UIKit.h>
#import <React/RCTConvert.h>
#import <AlipaySDK/AlipaySDK.h>

@implementation RNTAlipay

+ (BOOL)handleOpenURL:(UIApplication *)application openURL:(NSURL *)url
options:(NSDictionary<NSString*, id> *)options {
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:nil];
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:nil];
        return YES;
    }
    return NO;
}

+ (BOOL)requiresMainQueueSetup {
    return YES;
}

- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE(RNTAlipay);

RCT_EXPORT_METHOD(auth:(NSDictionary*)options
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject) {
    
    NSString *authInfo = [RCTConvert NSString:options[@"authString"]];
    NSString *appScheme = [RCTConvert NSString:options[@"appScheme"]];

    [[AlipaySDK defaultService] auth_V2WithInfo:authInfo fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        
        NSMutableDictionary *response = [[NSMutableDictionary alloc] init];
        
        NSString *resultStatus = resultDic[@"resultStatus"] ?: @"1";

        if ([resultStatus isEqualToString:@("9000")]) {
            response[@"code"] = @(0);
            response[@"msg"] = @("success");
            response[@"data"] = resultDic[@"result"] ?: @"";
        }
        else {
            response[@"code"] = @([resultStatus intValue]);
            response[@"msg"] = resultDic[@"memo"] ?: @"";
        }
        
        resolve(response);
        
    }];
    
}

RCT_EXPORT_METHOD(pay:(NSDictionary*)options
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject) {
    
    NSString *orderInfo = [RCTConvert NSString:options[@"orderString"]];
    NSString *appScheme = [RCTConvert NSString:options[@"appScheme"]];

    [[AlipaySDK defaultService] payOrder:orderInfo fromScheme:appScheme callback:^(NSDictionary *resultDic) {

        NSMutableDictionary *response = [[NSMutableDictionary alloc] init];
        
        NSString *resultStatus = resultDic[@"resultStatus"] ?: @"1";
        
        if ([resultStatus isEqualToString:@("9000")]) {
            response[@"code"] = @(0);
            response[@"msg"] = @("success");
            response[@"data"] = resultDic[@"result"] ?: @"";
        }
        else {
            response[@"code"] = @([resultStatus intValue]);
            response[@"msg"] = resultDic[@"memo"] ?: @"";
        }
        
        resolve(response);
        
    }];
    
}

@end
