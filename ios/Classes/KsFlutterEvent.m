//
//  KsFlutterEvent.m
//  ks_ads_flutter
//
//  Created by 爱互动 on 2021/9/13.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import "KsFlutterEvent.h"

@implementation KsFlutterEvent {
    FlutterEventSink eventSink;
}

- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    FlutterEventChannel *eventChannel = [FlutterEventChannel eventChannelWithName:@"com.ahd.ks_ads/ad_event" binaryMessenger:registrar.messenger];
    [eventChannel setStreamHandler:self];
    return self;
}

- (FlutterError * _Nullable)onCancelWithArguments:(id _Nullable)arguments {
    eventSink = nil;
    return nil;
}

- (FlutterError * _Nullable)onListenWithArguments:(id _Nullable)arguments eventSink:(nonnull FlutterEventSink)events {
    eventSink = events;
    return nil;
}

- (void)sendEvent:(NSDictionary *)event {
    eventSink(event);
}

@end
