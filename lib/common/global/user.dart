import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_flutter_basic/common/common.dart';

class UserController extends GetxService with WidgetsBindingObserver {
  static UserController get to => Get.find();

  // 初始化等待方法
  // final Completer<void> _initCompleter = Completer<void>();
  // Future<void> get initComplete => _initCompleter.future;

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

  // 切换到后台断开wss的时长
  Timer? _disconnectTimer;

  @override
  void onReady() {
    startCheckingForHotUpdates();
    super.onReady();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    // 监视 App 是否切换到后台
    switch (state) {
      case AppLifecycleState.resumed:
        MyLogger.w('app 切换到了前台');
        _disconnectTimer?.cancel();
        _disconnectTimer = null;
        if (isWssCanConnection) {
          UserController.to.myWss?.connect();
        }
        break;
      case AppLifecycleState.paused:
        MyLogger.w('app 切换到了后台');
        _disconnectTimer = Timer(Duration(minutes: 1), () {
          MyLogger.w('1 分钟未回到前台，断开 WebSocket');
          UserController.to.myWss?.close();
        });
        break;
      default:
        break;
    }
    super.didChangeAppLifecycleState(state);
  }
}