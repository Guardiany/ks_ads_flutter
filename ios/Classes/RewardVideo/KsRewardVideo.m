//
//  KsRewardVideo.m
//  ks_ads_flutter
//
//  Created by 爱互动 on 2021/9/13.
//

#import <Foundation/Foundation.h>
#import "KsRewardVideo.h"
#import <KSAdSDK/KSAdSDK.h>

@interface KsRewardVideo () <KSRewardedVideoAdDelegate>

@property (nonatomic, strong) KSRewardedVideoAd *rewardVideoAd;

@end

@implementation KsRewardVideo {
    BOOL _isShowLog;
    BOOL autoShowAd;
    NSDictionary *dic;
}

+ (KsRewardVideo *)instance {
    static KsRewardVideo* instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self.class alloc] init];
    });
    return instance;
}

- (void)loadRewardVideoWithArgs:(NSDictionary *)args {
    autoShowAd = false;
    dic = args;
    
    NSString *posId = dic[@"posId"];
    NSNumber *isShowLog = dic[@"isShowLog"];
    _isShowLog = [isShowLog boolValue];
    
    KSRewardedVideoModel *model = [KSRewardedVideoModel new];
    model.userId = @"";
    model.extra = @"";
    self.rewardVideoAd = [[KSRewardedVideoAd alloc] initWithPosId:posId rewardedVideoModel:model];
    self.rewardVideoAd.delegate = self;
    [self.rewardVideoAd loadAdData];
}

- (void)showRewardVideo {
    if (self.rewardVideoAd.isValid) {
        UIViewController *rootViewController = [[UIApplication sharedApplication] keyWindow].rootViewController;
        [self.rewardVideoAd showAdFromRootViewController:rootViewController];
    } else {
        if (dic != nil) {
            [self loadAndShowRewardVideo:dic];
        }
    }
}

- (void)loadAndShowRewardVideo:(NSDictionary *)args {
    autoShowAd = true;
    dic = args;
    
    NSString *posId = dic[@"posId"];
    NSNumber *isShowLog = dic[@"isShowLog"];
    _isShowLog = [isShowLog boolValue];
    
    KSRewardedVideoModel *model = [KSRewardedVideoModel new];
    model.userId = @"";
    model.extra = @"";
    self.rewardVideoAd = [[KSRewardedVideoAd alloc] initWithPosId:posId rewardedVideoModel:model];
    self.rewardVideoAd.delegate = self;
    [self.rewardVideoAd loadAdData];
}

- (void)showDebugLog:(NSString *)message {
    if (_isShowLog) {
        NSLog(@"%@", message);
    }
}

#pragma mark - KSRewardedVideoAdDelegate

- (void)rewardedVideoAd:(KSRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    NSString *errorMessage = [NSString stringWithFormat:@"广告数据加载失败 (errorCode=%ld)", (long)error.code];
    [self showDebugLog:errorMessage];
    NSDictionary *result = [[NSDictionary alloc] initWithObjectsAndKeys:@"rewardAd", @"adType", @"onError", @"method", errorMessage, @"errorMessage", nil];
    [ad_event sendEvent:result];
}

- (void)rewardedVideoAdDidLoad:(KSRewardedVideoAd *)rewardedVideoAd {
    [self showDebugLog:@"广告数据加载成功"];
    NSDictionary *result = [[NSDictionary alloc] initWithObjectsAndKeys:@"rewardAd", @"adType", @"onLoad", @"method", nil];
    [ad_event sendEvent:result];
    if (autoShowAd) {
        [self showRewardVideo];
    }
}

- (void)rewardedVideoAdVideoDidLoad:(KSRewardedVideoAd *)rewardedVideoAd {
    [self showDebugLog:@"广告数据缓存成功"];
}

- (void)rewardedVideoAdWillVisible:(KSRewardedVideoAd *)rewardedVideoAd {
    [self showDebugLog:@"广告即将显示"];
    NSDictionary *result = [[NSDictionary alloc] initWithObjectsAndKeys:@"rewardAd", @"adType", @"onWillVisible", @"method", nil];
    [ad_event sendEvent:result];
}

- (void)rewardedVideoAdStartPlay:(KSRewardedVideoAd *)rewardedVideoAd {
    [self showDebugLog:@"广告即将播放"];
}

- (void)rewardedVideoAdDidVisible:(KSRewardedVideoAd *)rewardedVideoAd {
    [self showDebugLog:@"广告已经显示"];
    NSDictionary *result = [[NSDictionary alloc] initWithObjectsAndKeys:@"rewardAd", @"adType", @"onShow", @"method", nil];
    [ad_event sendEvent:result];
}

- (void)rewardedVideoAdWillClose:(KSRewardedVideoAd *)rewardedVideoAd {
    [self showDebugLog:@"广告即将关闭"];
    NSDictionary *result = [[NSDictionary alloc] initWithObjectsAndKeys:@"rewardAd", @"adType", @"onWillClose", @"method", nil];
    [ad_event sendEvent:result];
}

- (void)rewardedVideoAdDidClose:(KSRewardedVideoAd *)rewardedVideoAd {
    [self showDebugLog:@"广告已经关闭"];
    NSDictionary *result = [[NSDictionary alloc] initWithObjectsAndKeys:@"rewardAd", @"adType", @"onClose", @"method", nil];
    [ad_event sendEvent:result];
}

- (void)rewardedVideoAdDidClick:(KSRewardedVideoAd *)rewardedVideoAd {
    [self showDebugLog:@"广告已经点击"];
    NSDictionary *result = [[NSDictionary alloc] initWithObjectsAndKeys:@"rewardAd", @"adType", @"onClick", @"method", nil];
    [ad_event sendEvent:result];
}

- (void)rewardedVideoAdDidPlayFinish:(KSRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    if (error == nil) {
        [self showDebugLog:@"广告播放完毕"];
    } else {
        [self showDebugLog:@"广告播放出错"];
        NSString *errorMessage = [NSString stringWithFormat:@"广告播放出错 (errorCode=%ld)", (long)error.code];
        NSDictionary *result = [[NSDictionary alloc] initWithObjectsAndKeys:@"rewardAd", @"adType", @"onError", @"method", errorMessage, @"errorMessage", nil];
        [ad_event sendEvent:result];
    }
}

- (void)rewardedVideoAdDidClickSkip:(KSRewardedVideoAd *)rewardedVideoAd {
    [self showDebugLog:@"点击跳过"];
    NSDictionary *result = [[NSDictionary alloc] initWithObjectsAndKeys:@"rewardAd", @"adType", @"onSkip", @"method", nil];
    [ad_event sendEvent:result];
}

- (void)rewardedVideoAd:(KSRewardedVideoAd *)rewardedVideoAd hasReward:(BOOL)hasReward {
    if (hasReward) {
        [self showDebugLog:@"奖励达成"];
        NSDictionary *result = [[NSDictionary alloc] initWithObjectsAndKeys:@"rewardAd", @"adType", @"onReward", @"method", nil];
        [ad_event sendEvent:result];
    }
}

@end
