#import "KsAdsFlutterPlugin.h"
#import <KSAdSDK/KSAdSDK.h>
#import "RewardVideoViewFactory.h"
#import "KsRewardVideo.h"
#import "KsFlutterEvent.h"

KsFlutterEvent *ad_event;

@implementation KsAdsFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"ks_ads_flutter"
            binaryMessenger:[registrar messenger]];
  KsAdsFlutterPlugin* instance = [[KsAdsFlutterPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
  [registrar registerViewFactory:[[RewardVideoViewFactory alloc] initWithMessenger:registrar.messenger] withId:@"com.ahd.ks_ads.reward_video"];
  ad_event = [[KsFlutterEvent alloc] initWithRegistrar:registrar];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    }
    else if ([@"getSdkVersion" isEqualToString:call.method]) {
        result(KSAdSDKManager.SDKVersion);
    }
    else if ([@"register" isEqualToString:call.method]) {
        NSDictionary *map = call.arguments;
        NSString *appId = [map valueForKey:@"appId"];
        [KSAdSDKManager setAppId:appId];
        [KSAdSDKManager setLoglevel:KSAdSDKLogLevelOff];
        result([NSNumber numberWithBool:true]);
    }
    else if ([@"loadAndShowRewardVideo" isEqualToString:call.method]) {
        [[KsRewardVideo instance] loadAndShowRewardVideo:call.arguments];
        result(nil);
    }
    else if ([@"loadRewardVideo" isEqualToString:call.method]) {
        [[KsRewardVideo instance] loadRewardVideoWithArgs:call.arguments];
        result(nil);
    }
    else if ([@"showRewardVideo" isEqualToString:call.method]) {
        [[KsRewardVideo instance] showRewardVideo];
        result(nil);
    }
    else {
        result(FlutterMethodNotImplemented);
    }
}

@end
