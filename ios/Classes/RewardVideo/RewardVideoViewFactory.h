//
//  RewardVideoViewFactory.h
//  ks_ads_flutter
//
//  Created by 爱互动 on 2021/9/8.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

@interface RewardVideoViewFactory : NSObject<FlutterPlatformViewFactory>

- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messager;

@end
