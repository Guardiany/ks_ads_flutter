//
//  KsFlutterEvent.h
//  ks_ads_flutter
//
//  Created by 爱互动 on 2021/9/13.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

@interface KsFlutterEvent : NSObject<FlutterStreamHandler>

- (instancetype)initWithRegistrar: (NSObject<FlutterPluginRegistrar>*)registrar;

- (void)sendEvent:(NSDictionary *)event;

@end
