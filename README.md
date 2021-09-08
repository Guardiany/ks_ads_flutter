# 快手联盟广告sdk Flutter版本

## 简介
  ks_ads_flutter是一款集成了快手联盟广告sdk的Flutter插件,目前仅支持iOS端部分功能，剩余功能和Android端正在开发

## 官方文档
* [Android](https://static.yximgs.com/udata/pkg/KS-Android-KSAdSDk/doc/4701b963d40a77bc0f45fd71d30b57da44.pdf)
* [IOS](https://static.yximgs.com/udata/pkg/KSAdSDKTarGz/doc/ksadsdk-iOS-readme-ad-3.3.14.pdf)

## 集成步骤
#### 1、pubspec.yaml
```Dart
ks_ads_flutter:
  git: https://github.com/Guardiany/ks_ads_flutter.git
```

#### 2、IOS
SDK最新版本已配置插件中，其余根据SDK文档配置，在Info.plist加入
```
 <key>io.flutter.embedded_views_preview</key>
    <true/>
```

## 使用

#### 1、SDK初始化
```Dart
await KsAdsFlutter.register(iosAppId: '你的appID');
```
#### 2、获取SDK版本
```Dart
await KsAdsFlutter.sdkVersion;
```
#### 3、激励视频
```Dart
KsAdsFlutter.rewardVideoView(
        context: context,
        placementId: '你的广告位ID',
        videoMuted: true,
        callback: RewardVideoCallback(
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
```

## 联系方式
* Email: 1204493146@qq.com
