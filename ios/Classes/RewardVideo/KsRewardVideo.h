//
//  KsRewardVideo.h
//  ks_ads_flutter
//
//  Created by 爱互动 on 2021/9/13.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import "KsFlutterEvent.h"

@interface KsRewardVideo : NSObject

extern KsFlutterEvent *ad_event;

+ (KsRewardVideo *)instance;

- (void)loadAndShowRewardVideo:(NSDictionary *)args;

- (void)loadRewardVideoWithArgs:(NSDictionary *)args;

- (void)showRewardVideo;

@end
