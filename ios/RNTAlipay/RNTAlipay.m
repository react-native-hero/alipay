#import "RNTAlipay.h"
#import <UIKit/UIKit.h>
#import <React/RCTConvert.h>
#import <AlipaySDK/AlipaySDK.h>

@implementation RNTAlipay

+ (BOOL)requiresMainQueueSetup {
    return YES;
}

- (dispatch_queue_t)methodQueue {
    return dispatch_queue_create("com.github.reactnativehero.alipay", DISPATCH_QUEUE_SERIAL);
}

RCT_EXPORT_MODULE(RNTAlipay);

RCT_EXPORT_METHOD(pay:(NSDictionary*)options
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject) {
    
    NSString *orderInfo = [RCTConvert NSString:options[@"orderString"]];
    NSString *appScheme = [RCTConvert NSString:options[@"appScheme"]];
    
    [[AlipaySDK defaultService] payOrder:orderInfo fromScheme:appScheme callback:^(NSDictionary *resultDic) {

        NSMutableDictionary *response = [[NSMutableDictionary alloc] init];
        
        NSString *resultStatus = resultDic[@"resultStatus"] ?: @"1";
        
        if ([resultStatus isEqualToString:@("9000")]) {
            response[@"code"] = 0;
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
