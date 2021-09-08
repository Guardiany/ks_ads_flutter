//
//  RewardVideoViewFactory.m
//  ks_ads_flutter
//
//  Created by 爱互动 on 2021/9/8.
//

#import <Foundation/Foundation.h>
#import "RewardVideoViewFactory.h"
#import "RewardVideoView.h"

@implementation RewardVideoViewFactory{
    NSObject<FlutterBinaryMessenger> *_messenger;
}

- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger> *)messager {
    self = [super init];
    if (self) {
        _messenger = messager;
    }
    return self;
}

//设置参数的编码方式
- (NSObject<FlutterMessageCodec>*)createArgsCodec{
    return [FlutterStandardMessageCodec sharedInstance];
}

- (nonnull NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id _Nullable)args {
    RewardVideoView *videoView = [[RewardVideoView alloc] initWithFrame:frame viewIdentifier:viewId arguments:args binaryMessenger:_messenger];
    return videoView;
}

@end
