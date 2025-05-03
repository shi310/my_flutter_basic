import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common.dart';

Future<void> initialized() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 导入用户控制器
  Get.put(UserController());

  await Future.wait([
    // 初始化主题
    initTheme(),
    // 初始化语言
    initLocale(),
    // 初始化深度链接
    initDeepLink(),
    // 初始化APP信息
    initDeviceInfo(),
    // 初始化OpenInstall
    initOpenInstall(),
    // 初始化APP数据
    initAppData(),
  ]);
}



