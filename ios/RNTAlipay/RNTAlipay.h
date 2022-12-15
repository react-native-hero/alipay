#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface RNTAlipay : RCTEventEmitter <RCTBridgeModule>

+ (BOOL)handleOpenURL:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options;

@end
