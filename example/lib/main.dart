import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ks_ads_flutter/ks_ads_flutter.dart';
import 'package:ks_ads_flutter_example/reward_video_page.dart';

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

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _initSdk();
  }

  _initSdk() async {
    _registerResult = await KsAdsFlutter.register(iosAppId: '1200064850');
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
            // TextButton(onPressed: () {
            //   Navigator.push(context, MaterialPageRoute(builder: (con) {
            //     return SplashViewPage();
            //   }));
            // }, child: Text('开屏广告', style: TextStyle(fontSize: 18),),),
            TextButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (con) {
                return RewardVideoViewPage();
              }));
            }, child: Text('激励视频', style: TextStyle(fontSize: 18),),),
          ],
        ),
      ),
    );
  }
}