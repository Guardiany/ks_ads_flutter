//
//  RewardVideoView.h
//  ks_ads_flutter
//
//  Created by 爱互动 on 2021/9/8.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

@interface RewardVideoView : NSObject<FlutterPlatformView>

-(instancetype)initWithFrame:(CGRect)frame
                  viewIdentifier:(int64_t)viewId
                       arguments:(id _Nullable)args
                 binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;

@end
