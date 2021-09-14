
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ks_ads_flutter/reward_video/reward_video_view.dart';

import 'ks_ads_callback.dart';

class KsAdsFlutter {
  static const MethodChannel _channel =
      const MethodChannel('ks_ads_flutter');
  static const EventChannel adEventEvent = const EventChannel("com.ahd.ks_ads/ad_event");

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String?> get sdkVersion async {
    return await _channel.invokeMethod('getSdkVersion');
  }

  static Future<bool?> register({
    required String iosAppId,
    required String androidAppId,
    required String appName,
    bool isShowLog = false,
  }) async {
    final bool? result = await _channel.invokeMethod('register', {
      'appId': iosAppId,
      'androidAppId': androidAppId,
      'appName': appName,
      'isShowLog': isShowLog,
    });
    return result;
  }

  ///预加载激励视频
  static void loadRewardVideo({
    required String posId,
    bool isShowLog = false,
    ///设置激励视频是否静音
    bool videoMuted = false,
  }) {
    _channel.invokeMethod('loadRewardVideo', {
      'posId': posId,
      'isShowLog': isShowLog,
      'videoMuted': videoMuted,
    });
  }

  ///显示激励视频
  static void showReardVideo() {
    _channel.invokeMethod('showRewardVideo', {});
  }

  ///加载并播放激励视频
  static void loadAndShowRewardVideo({
    required String posId,
    bool isShowLog = false,
    ///设置激励视频是否静音
    bool videoMuted = false,
  }) async {
    _channel.invokeMethod('loadAndShowRewardVideo', {
      'posId': posId,
      'isShowLog': isShowLog,
      'videoMuted': videoMuted,
    });
  }

  ///设置激励视频监听
  static StreamSubscription initRewardStream(KsRewardVideoCallback callback) {
    StreamSubscription _adStream = adEventEvent.receiveBroadcastStream().listen((data) {
      if (data['adType'] != 'rewardAd') {
        return;
      }
      switch (data['method']){
        case 'onLoad':
          callback.onLoad!();
          break;
        case 'onShow':
          callback.onShow!();
          break;
        case 'onError':
          callback.onFail!(data['errorMessage']);
          break;
        case 'onWillVisible':
          break;
        case 'onClick':
          callback.onClick!();
          break;
        case 'onFinish':
          callback.onFinish!();
          break;
        case 'onClosed':
          callback.onClose!();
          break;
        case 'onReward':
          callback.onReward!();
          break;
        case 'onSkip':
          callback.onSkip!();
          break;
      }
    });
    return _adStream;
  }

  ///激励视频
  static Widget rewardVideoView({
    required BuildContext context,
    double? width,
    double? height,
    required String placementId,
    bool isShowLog = false,
    ///设置激励视频是否静音
    bool videoMuted = false,
    KsRewardVideoCallback? callback,
  }) {
    if (width == null) {
      width = MediaQuery.of(context).size.width;
    }
    if (height == null) {
      height = MediaQuery.of(context).size.height;
    }
    return RewardVideoView(
      placementId: placementId,
      width: width,
      height: height,
      isShowLog: isShowLog,
      videoMuted: videoMuted,
      callback: callback,
    );
  }
}
