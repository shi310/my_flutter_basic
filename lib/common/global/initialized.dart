import 'package:my_flutter_basic/common/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    // initDeviceInfo
    initDeviceInfo(),
  ]);
}



