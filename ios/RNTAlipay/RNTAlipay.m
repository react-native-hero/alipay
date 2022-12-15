#import <UIKit/UIKit.h>
#import <React/RCTConvert.h>
#import <AlipaySDK/AlipaySDK.h>

@implementation RNTAlipay

+ (BOOL)handleOpenURL:(UIApplication *)application openURL:(NSURL *)url
options:(NSDictionary<NSString*, id> *)options {
    if ([url.host isEqualToString:@"safepay"]) {
        // 跳转支付宝客户端进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@", resultDic);
        }];
    }
    return NO;
}

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
    
    NSString *orderInfo = [RCTConvert NSString:options[@"order_info"]];
    NSString *appScheme = [RCTConvert NSString:options[@"app_scheme"]];
    
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@", resultDic);
    }];
    
}

@end
