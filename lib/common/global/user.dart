import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_device_info/models/my_device_info_model.dart';
import 'package:my_flutter_basic/common/common.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

class UserController extends GetxController with WidgetsBindingObserver {
  static UserController get to => Get.find();
  // dio 请求
  MyDio? myDio;

  // wss 通信
  MyWss? myWss;

  // 是否允许连接 wss
  bool isWssCanConnection = true;

  // baseUrls 数组
  List<String> baseUrlList = [];

  // wssUrls 数组
  List<String> wssUrlList = [];

  // 用户 token
  String userToken = '';

  // 热更新定时器
  Timer? timerHotUpdate;

  // 热更新
  ShorebirdUpdater shorebirdUpdater = ShorebirdUpdater();

  // 应用信息
  MyDeviceInfoModel? deviceInfo;

  // 切换到后台断开wss的时长
  Timer? _disconnectTimer;

  // 是否使用过APP
  String isUsedApp = '1';

  // localTag
  MyLocaleMode? myLocaleMode;

  // themeModeTag
  MyThemeMode? myThemeMode;

  @override
  void onReady() {
    // 检查热更新
    startCheckingForHotUpdates();
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
    // 初始化监听
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    // 释放监听
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  void _onResumed() {
    MyLogger.w('检测到 app 切换到了前台...');
    _disconnectTimer?.cancel();
    _disconnectTimer = null;
    if (isWssCanConnection) {
      myWss?.connect();
    }
  }

  void _onPaused() {
    MyLogger.w('检测到 app 切换到了后台...');
    _disconnectTimer = Timer(Duration(minutes: 1), () {
      MyLogger.w('1 分钟未回到前台，断开 WebSocket');
      myWss?.close();
    });
  }

  void _onClose() {
    MyLogger.w('检测到 App 彻底退出...');
    timerHotUpdate?.cancel();
    _disconnectTimer?.cancel();
    myWss?.close();
    myDio?.cancel();
    WidgetsBinding.instance.removeObserver(this);
  }

  void _onSystemThemeModeLister() {
    MyLogger.w('检测到系统主题变化...');

    if (myThemeMode != null) {
      return;
    }

    MyTheme.update(mode: MyThemeMode.system);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        _onResumed();
        break;
      case AppLifecycleState.paused:
        _onPaused();
        break;
      case AppLifecycleState.detached:
        _onClose();
        break;
      default:
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void didChangePlatformBrightness() {
    _onSystemThemeModeLister();
  }
}