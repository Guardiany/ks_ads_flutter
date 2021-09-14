package com.ahd.ks_ads_flutter;

import android.app.Activity;
import android.content.Context;

import androidx.annotation.NonNull;

import com.kwad.sdk.api.KsAdSDK;
import com.kwad.sdk.api.SdkConfig;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** KsAdsFlutterPlugin */
public class KsAdsFlutterPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Context appContext;
  private Activity mActivity;
  private String appId;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "ks_ads_flutter");
    channel.setMethodCallHandler(this);
    appContext = flutterPluginBinding.getApplicationContext();
    KsFlutterEvent.getInstance().onAttachedToEngine(flutterPluginBinding);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    switch (call.method) {
      case "getPlatformVersion":
        result.success("Android " + android.os.Build.VERSION.RELEASE);
        break;
      case "getSdkVersion":
        result.success(KsAdSDK.getSDKVersion());
        break;
      case "register":
        String appId = call.argument("androidAppId");
        String appName = call.argument("appName");
        boolean isShowLog = call.argument("isShowLog");
        KsRewardVideo.getInstance().setShowLog(isShowLog);
        boolean initResult = KsAdSDK.init(
                appContext,
                new SdkConfig.Builder().appId(appId).appName(appName).showNotification(true).debug(isShowLog).build()
        );
        if (initResult) {
          this.appId = appId;
        }
        result.success(initResult);
        break;
      case "loadRewardVideo":
        KsRewardVideo.getInstance().loadRewardVideo(Integer.parseInt(this.appId));
        result.success(null);
        break;
      case "showRewardVideo":
        KsRewardVideo.getInstance().showRewardVideo(mActivity);
        result.success(null);
        break;
      default:
        result.notImplemented();
        break;
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    mActivity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    mActivity = null;
  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    mActivity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivity() {
    mActivity = null;
  }
}
