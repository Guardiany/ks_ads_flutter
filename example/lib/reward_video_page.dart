
import 'package:flutter/material.dart';
import 'package:ks_ads_flutter/ks_ads_callback.dart';
import 'package:ks_ads_flutter/ks_ads_flutter.dart';

class RewardVideoViewPage extends StatefulWidget {
  const RewardVideoViewPage({Key? key}) : super(key: key);

  @override
  _RewardVideoViewPageState createState() => _RewardVideoViewPageState();
}

class _RewardVideoViewPageState extends State<RewardVideoViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KsAdsFlutter.rewardVideoView(
        context: context,
        placementId: '4072435033794278',
        videoMuted: true,
        callback: KsRewardVideoCallback(
          onLoad: () {
            print('onLoad');
          },
          onFail: (error) {
            print('$error');
          },
          onShow: () {
            print('onShow');
          },
          onClick: () {
            print('onClick');
          },
          onFinish: () {
            print('onFinish');
          },
          onClose: () {
            print('onClose');
            Navigator.pop(context);
          },
          onReward: () {
            print('onReward');
          },
          onSkip: () {
            print('onSkip');
          },
        ),
      ),
    );
  }
}
