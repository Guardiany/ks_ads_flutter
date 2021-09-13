
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../ks_ads_callback.dart';

class RewardVideoView extends StatefulWidget {

  const RewardVideoView({
    Key? key,
    this.width,
    this.height,
    required this.placementId,
    this.isShowLog = false,
    this.videoMuted = false,
    this.callback,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String placementId;
  final bool isShowLog;
  final bool videoMuted;
  final KsRewardVideoCallback? callback;

  @override
  _RewardVideoViewState createState() => _RewardVideoViewState();
}

class _RewardVideoViewState extends State<RewardVideoView> {

  final String _viewType = 'com.ahd.ks_ads.reward_video';
  MethodChannel? _channel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Center(
        child: UiKitView(
          viewType: _viewType,
          creationParams: {
            'posId': '${widget.placementId}',
            'isShowLog': widget.isShowLog,
            'videoMuted': widget.videoMuted,
          },
          creationParamsCodec: const StandardMessageCodec(),
          onPlatformViewCreated: _registerChannel,
        ),
      ),
    );
  }

  void _registerChannel(int id) {
    _channel = MethodChannel("${_viewType}_$id");
    _channel?.setMethodCallHandler(_platformCallHandler);
  }

  Future<dynamic> _platformCallHandler(MethodCall call) async {
    if (widget.callback == null) {
      return;
    }
    switch (call.method) {
      case 'onLoad':
        widget.callback?.onLoad!();
        break;
      case 'onShow':
        widget.callback?.onShow!();
        break;
      case 'error':
        widget.callback?.onFail!(call.arguments);
        break;
      case 'onWillVisible':
        break;
      case 'onClick':
        widget.callback?.onClick!();
        break;
      case 'onFinish':
        widget.callback?.onFinish!();
        break;
      case 'onClosed':
        widget.callback?.onClose!();
        break;
      case 'onReward':
        widget.callback?.onReward!();
        break;
      case 'onSkip':
        widget.callback?.onSkip!();
        break;
    }
  }
}
