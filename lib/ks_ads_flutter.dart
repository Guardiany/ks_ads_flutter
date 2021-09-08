
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ks_ads_flutter/reward_video/reward_video_view.dart';

import 'ks_ads_callback.dart';

class KsAdsFlutter {
  static const MethodChannel _channel =
      const MethodChannel('ks_ads_flutter');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String?> get sdkVersion async {
    return await _channel.invokeMethod('getSdkVersion');
  }

  static Future<bool?> register({
    required String iosAppId,
  }) async {
    final bool? result = await _channel.invokeMethod('register', {'appId': iosAppId});
    return result;
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
    RewardVideoCallback? callback,
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
