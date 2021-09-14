package com.ahd.ks_ads_flutter;

import androidx.annotation.NonNull;

import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.EventChannel;

public class KsFlutterEvent implements FlutterPlugin, EventChannel.StreamHandler {

    private static final KsFlutterEvent instance = new KsFlutterEvent();

    public static KsFlutterEvent getInstance() {
        return instance;
    }

    private EventChannel eventChannel;
    private EventChannel.EventSink eventSink;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        eventChannel = new EventChannel(binding.getBinaryMessenger(), "com.ahd.ks_ads/ad_event");
        eventChannel.setStreamHandler(this);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        eventChannel.setStreamHandler(null);
        eventChannel = null;
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        eventSink = events;
    }

    @Override
    public void onCancel(Object arguments) {
        eventSink = null;
    }

    public void sendEvent(Map<String, Object> content) {
        if (eventSink != null) {
            eventSink.success(content);
        }
    }
}
