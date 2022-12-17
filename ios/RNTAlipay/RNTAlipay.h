#import <React/RCTBridgeModule.h>

@interface RNTAlipay : NSObject <RCTBridgeModule>

+ (BOOL)handleOpenURL:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options;

@end
