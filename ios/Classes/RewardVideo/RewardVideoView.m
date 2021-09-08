//
//  RewardVideoView.m
//  ks_ads_flutter
//
//  Created by 爱互动 on 2021/9/8.
//

#import <Foundation/Foundation.h>
#import "RewardVideoView.h"
#import <KSAdSDK/KSAdSDK.h>

@interface RewardVideoView () <KSRewardedVideoAdDelegate>

@end

@implementation RewardVideoView {
    int64_t _viewId;
    FlutterMethodChannel* _channel;
    BOOL _isShowLog;
    BOOL _videoMuted;
    UIWindow *_container;
    KSRewardedVideoAd *rewardedVideoAd;
}

- (instancetype)initWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args binaryMessenger:(NSObject<FlutterBinaryMessenger> *)messenger {
    
    NSString *methodName = [NSString stringWithFormat:@"com.ahd.ks_ads.reward_video_%lld", viewId];
    _channel = [FlutterMethodChannel methodChannelWithName:methodName binaryMessenger:messenger];
    
    _container = [[UIWindow alloc] initWithFrame:frame];
    _container.rootViewController = [[UIApplication sharedApplication] keyWindow].rootViewController;
    
    NSDictionary *dic = args;
    NSString *posId = dic[@"posId"];
    NSNumber *isShowLog = dic[@"isShowLog"];
    _isShowLog = [isShowLog boolValue];
    
    KSRewardedVideoModel *model = [KSRewardedVideoModel new];
    model.userId = @"";
    model.extra = @"";
    rewardedVideoAd = [[KSRewardedVideoAd alloc] initWithPosId:posId rewardedVideoModel:model];
    rewardedVideoAd.delegate = self;
    [rewardedVideoAd loadAdData];
    
    return self;
}

- (nonnull UIView *)view {
    return _container;
}

#pragma mark - KSRewardedVideoAdDelegate

- (void)rewardedVideoAd:(KSRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    [self showDebugLog:@"广告数据加载失败"];
    [_channel invokeMethod:@"error" arguments:[NSString stringWithFormat:@"错误码：%ld", (long)error.code]];
}

- (void)rewardedVideoAdDidLoad:(KSRewardedVideoAd *)rewardedVideoAd {
    [self showDebugLog:@"广告数据加载成功"];
    [_channel invokeMethod:@"onLoad" arguments:nil];
    [rewardedVideoAd showAdFromRootViewController:_container.rootViewController];
}

- (void)rewardedVideoAdVideoDidLoad:(KSRewardedVideoAd *)rewardedVideoAd {
    [self showDebugLog:@"广告数据缓存成功"];
}

- (void)rewardedVideoAdWillVisible:(KSRewardedVideoAd *)rewardedVideoAd {
    [self showDebugLog:@"广告即将显示"];
}

- (void)rewardedVideoAdStartPlay:(KSRewardedVideoAd *)rewardedVideoAd {
    [self showDebugLog:@"广告即将播放"];
}

- (void)rewardedVideoAdDidVisible:(KSRewardedVideoAd *)rewardedVideoAd {
    [self showDebugLog:@"广告已经显示"];
    [_channel invokeMethod:@"onShow" arguments:nil];
}

- (void)rewardedVideoAdWillClose:(KSRewardedVideoAd *)rewardedVideoAd {
    [self showDebugLog:@"广告即将关闭"];
    [_channel invokeMethod:@"onWillClose" arguments:nil];
}

- (void)rewardedVideoAdDidClose:(KSRewardedVideoAd *)rewardedVideoAd {
    [self showDebugLog:@"广告已经关闭"];
    [_channel invokeMethod:@"onClose" arguments:nil];
}

- (void)rewardedVideoAdDidClick:(KSRewardedVideoAd *)rewardedVideoAd {
    [self showDebugLog:@"广告已经点击"];
    [_channel invokeMethod:@"onClick" arguments:nil];
}

- (void)rewardedVideoAdDidPlayFinish:(KSRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    if (error == nil) {
        [self showDebugLog:@"广告播放完毕"];
        [_channel invokeMethod:@"onFinish" arguments:nil];
    } else {
        [self showDebugLog:@"广告播放出错"];
        [_channel invokeMethod:@"error" arguments:[NSString stringWithFormat:@"错误码：%ld", (long)error.code]];
    }
}

- (void)rewardedVideoAdDidClickSkip:(KSRewardedVideoAd *)rewardedVideoAd {
    [self showDebugLog:@"点击跳过"];
    [_channel invokeMethod:@"onSkip" arguments:nil];
}

- (void)showDebugLog:(NSString *)message {
    if (_isShowLog) {
        NSLog(@"%@", message);
    }
}

@end

