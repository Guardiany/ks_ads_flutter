
///显示
typedef OnShow = void Function();

///失败
typedef OnFail = void Function(dynamic message);

///不喜欢
typedef OnDislike = void Function(dynamic message);

///点击
typedef OnClick = void Function();

///视频播放
typedef OnVideoPlay = void Function();

///视频暂停
typedef OnVideoPause = void Function();

///视频播放结束
typedef OnVideoStop = void Function();

///跳过
typedef OnSkip = void Function();

///倒计时结束
typedef OnFinish = void Function();

///加载超时
typedef OnTimeOut = void Function();

///关闭
typedef OnClose = void Function();

///广告预加载完成
typedef OnLoad = void Function();

///广告预加载未完成
typedef OnUnReady = void Function();

///激励视频播放达到激励条件
typedef OnReward = void Function();

///开屏广告回调
class SplashViewCallback {

  OnLoad? onLoad;
  OnShow? onShow;
  OnFail? onFail;
  OnClick? onClick;
  OnFinish? onFinish;
  OnClose? onClose;

  SplashViewCallback({
    this.onLoad,
    this.onShow,
    this.onFail,
    this.onClick,
    this.onFinish,
    this.onClose,
  });
}

///激励广告回调
class KsRewardVideoCallback {

  OnLoad? onLoad;
  OnShow? onShow;
  OnFail? onFail;
  OnClick? onClick;
  OnFinish? onFinish;
  OnClose? onClose;
  OnReward? onReward;
  OnSkip? onSkip;

  KsRewardVideoCallback({
    this.onLoad,
    this.onClose,
    this.onFinish,
    this.onClick,
    this.onFail,
    this.onShow,
    this.onReward,
    this.onSkip,
  });
}