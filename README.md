# 快手联盟广告sdk Flutter版本

## 简介
  ks_ads_flutter是一款集成了快手联盟广告sdk的Flutter插件,目前仅支持显示激励视频功能，剩余功能正在开发

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

#### 3、Android
去官网[下载SDK](https://u.kuaishou.com/access)
请解压提供的⼴告SDK，在压缩包中找到ks_adsdk_xxx.aar
找到您的App⼯程下的libs⽂件夹，将上⾯的aar拷⻉到该⽬录下
在app的build.gradle⽂件中添加如下依赖:
```
allprojects {
    repositories {
        //本地⽂件仓库依赖
        flatDir { dirs 'libs'}
    }
}
```
```
dependencies {
    // 快⼿SDK aar包，请将提供的aar包拷⻉到libs⽬录下，添加依赖。根据接⼊版本修改SDK包名
    implementation files('libs/kssdk-ad--3.3.15-publishRelease-4533d8764.aar')
    def version = "1.3.1"
    // supprot库依赖，SDK内部依赖如下support，请确保添加
    implementation "androidx.appcompat:appcompat:$version"
    implementation "androidx.recyclerview:recyclerview:1.2.0"
}
```
权限和其他配置请查阅[官方文档](https://static.yximgs.com/udata/pkg/KS-Android-KSAdSDk/doc/4701b963d40a77bc0f45fd71d30b57da44.pdf)

## 使用

#### 1、SDK初始化
```Dart
_registerResult = await KsAdsFlutter.register(
      iosAppId: '你的苹果appID',
      androidAppId: '你的Android appID',
      appName: '你的app名',
    );
```
#### 2、获取SDK版本
```Dart
await KsAdsFlutter.sdkVersion;
```
#### 3、激励视频
```Dart
///预加载激励视频
KsAdsFlutter.loadRewardVideo(posId: '你的posId');

///播放激励视频
KsAdsFlutter.showReardVideo();

///设置激励视频监听
StreamSubscription _adStream = KsAdsFlutter.initRewardStream(KsRewardVideoCallback(
      onLoad: () {
        print('onLoad');
      },
      onFail: (error) {
        print('error: $error');
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
```

## 联系方式
* Email: 1204493146@qq.com
