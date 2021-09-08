#import "KsAdsFlutterPlugin.h"
#import <KSAdSDK/KSAdSDK.h>
#import "RewardVideoViewFactory.h"

@implementation KsAdsFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"ks_ads_flutter"
            binaryMessenger:[registrar messenger]];
  KsAdsFlutterPlugin* instance = [[KsAdsFlutterPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
  [registrar registerViewFactory:[[RewardVideoViewFactory alloc] initWithMessenger:registrar.messenger] withId:@"com.ahd.ks_ads.reward_video"];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    }
    if ([@"getSdkVersion" isEqualToString:call.method]) {
        result(KSAdSDKManager.SDKVersion);
    }
    if ([@"register" isEqualToString:call.method]) {
        NSDictionary *map = call.arguments;
        NSString *appId = [map valueForKey:@"appId"];
        [KSAdSDKManager setAppId:appId];
        result([NSNumber numberWithBool:true]);
    }
    else {
        result(FlutterMethodNotImplemented);
    }
}

@end
