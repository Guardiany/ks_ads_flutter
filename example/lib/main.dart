import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ks_ads_flutter/ks_ads_callback.dart';
import 'package:ks_ads_flutter/ks_ads_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext buildContext) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String _platformVersion = 'Unknown';
  String _sdkVersion = 'Unknown';
  bool? _registerResult;

  StreamSubscription? _adStream;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _initSdk();
    _adStream = KsAdsFlutter.initRewardStream(KsRewardVideoCallback(
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
      },
      onReward: () {
        print('onReward');
      },
      onSkip: () {
        print('onSkip');
      },
    ));
  }

  _initSdk() async {
    _registerResult = await KsAdsFlutter.register(iosAppId: '561000005');
    setState(() {});
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    String sdkVersionl;
    try {
      platformVersion = await KsAdsFlutter.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    try {
      sdkVersionl = await KsAdsFlutter.sdkVersion ?? 'Unknown Sdk version';
    } on PlatformException {
      sdkVersionl = 'Failed to get sdk version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _sdkVersion = sdkVersionl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Running on: $_platformVersion\nSdk Version: $_sdkVersion'),
            Text('${_registerResult == null ? '等待初始化sdk' : _registerResult! ? 'sdk初始化成功' : 'sdk初始化失败'}'),
            Padding(padding: EdgeInsets.only(top: 15)),
            TextButton(onPressed: () {
              KsAdsFlutter.loadAndShowRewardVideo(posId: '5610000005', isShowLog: true,);
            }, child: Text('激励视频', style: TextStyle(fontSize: 18),),),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _adStream?.cancel();
  }
}