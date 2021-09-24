package com.ahd.ks_ads_flutter;

import android.app.Activity;

import androidx.annotation.Nullable;

import com.kwad.sdk.api.KsAdSDK;
import com.kwad.sdk.api.KsLoadManager;
import com.kwad.sdk.api.KsRewardVideoAd;
import com.kwad.sdk.api.KsScene;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class KsRewardVideo {

    private final static KsRewardVideo instance = new KsRewardVideo();

    private KsRewardVideo() {

    }

    public static KsRewardVideo getInstance() {
        return instance;
    }

    private boolean isShowLog = false;
    private KsRewardVideoAd mRewardVideoAd;

    public void setShowLog(boolean showLog) {
        isShowLog = showLog;
    }

    public void loadRewardVideo(long posId) {
        KsLoadManager loadManager = KsAdSDK.getLoadManager();
        KsScene scene = new KsScene.Builder(posId).build();
        loadManager.loadRewardVideoAd(scene, new KsLoadManager.RewardVideoAdListener() {
            @Override
            public void onError(int i, String s) {
                //激励视频⼴告请求失败
                String errorMessage = "激励视频⼴告请求失败 (errorCode: " + i + ", msg: " + s + ")";
                if (isShowLog) {
                    System.out.println(errorMessage);
                }
                Map<String, Object> result = new HashMap<>();
                result.put("adType", "rewardAd");
                result.put("method", "onError");
                result.put("errorMessage", errorMessage);
                KsFlutterEvent.getInstance().sendEvent(result);
            }

            @Override
            public void onRequestResult(int i) {
                //激励视频⼴告请求填充
                String message = "激励视频⼴告请求填充 adNumber: " + i;
                if (isShowLog) {
                    System.out.println(message);
                }
            }

            @Override
            public void onRewardVideoAdLoad(@Nullable List<KsRewardVideoAd> list) {
                //激励视频⼴告请求成功
                String message = "激励视频⼴告请求成功";
                if (isShowLog) {
                    System.out.println(message);
                }
                if (list != null && list.size() > 0) {
                    mRewardVideoAd = list.get(0);
                }
                Map<String, Object> result = new HashMap<>();
                result.put("adType", "rewardAd");
                result.put("method", "onLoad");
                KsFlutterEvent.getInstance().sendEvent(result);
            }
        });
    }

    public void showRewardVideo(Activity activity) {
        if (mRewardVideoAd != null && mRewardVideoAd.isAdEnable()) {
            mRewardVideoAd.setRewardAdInteractionListener(new KsRewardVideoAd.RewardAdInteractionListener() {
                @Override
                public void onAdClicked() {
                    String message = "激励视频⼴告点击";
                    if (isShowLog) {
                        System.out.println(message);
                    }
                    Map<String, Object> result = new HashMap<>();
                    result.put("adType", "rewardAd");
                    result.put("method", "onClick");
                    KsFlutterEvent.getInstance().sendEvent(result);
                }

                @Override
                public void onPageDismiss() {
                    String message = "激励视频⼴告关闭";
                    if (isShowLog) {
                        System.out.println(message);
                    }
                    Map<String, Object> result = new HashMap<>();
                    result.put("adType", "rewardAd");
                    result.put("method", "onClose");
                    KsFlutterEvent.getInstance().sendEvent(result);
                }

                @Override
                public void onVideoPlayError(int i, int i1) {
                    String message = "激励视频⼴告播放出错 (errorCode: " + i + ", extra: " + i1 + ")";
                    if (isShowLog) {
                        System.out.println(message);
                    }
                    Map<String, Object> result = new HashMap<>();
                    result.put("adType", "rewardAd");
                    result.put("method", "onError");
                    result.put("errorMessage", message);
                    KsFlutterEvent.getInstance().sendEvent(result);
                }

                @Override
                public void onVideoPlayEnd() {
                    if (isShowLog) {
                        System.out.println("激励视频⼴告播放完成");
                    }
                }

                @Override
                public void onVideoSkipToEnd(long l) {
                    if (isShowLog) {
                        System.out.println("激励视频⼴告跳过");
                    }
                    Map<String, Object> result = new HashMap<>();
                    result.put("adType", "rewardAd");
                    result.put("method", "onSkip");
                    KsFlutterEvent.getInstance().sendEvent(result);
                }

                @Override
                public void onVideoPlayStart() {
                    if (isShowLog) {
                        System.out.println("激励视频⼴告播放开始");
                    }
                    Map<String, Object> result = new HashMap<>();
                    result.put("adType", "rewardAd");
                    result.put("method", "onShow");
                    KsFlutterEvent.getInstance().sendEvent(result);
                }

                @Override
                public void onRewardVerify() {
                    if (isShowLog) {
                        System.out.println("激励视频⼴告获取激励");
                    }
                    Map<String, Object> result = new HashMap<>();
                    result.put("adType", "rewardAd");
                    result.put("method", "onReward");
                    KsFlutterEvent.getInstance().sendEvent(result);
                }
            });
            mRewardVideoAd.showRewardVideoAd(activity, null);
        } else {
            String message = "暂⽆可⽤激励视频⼴告，请等待缓存加载或者重新刷新";
            if (isShowLog) {
                System.out.println(message);
            }
            Map<String, Object> result = new HashMap<>();
            result.put("adType", "rewardAd");
            result.put("method", "onError");
            result.put("errorMessage", message);
            KsFlutterEvent.getInstance().sendEvent(result);
        }
    }
}
