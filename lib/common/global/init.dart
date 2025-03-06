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
    initLang(),
    // 初始化深度链接
    initDeepLink(),
    // initDeviceInfo
    initDeviceInfo(),
  ]);

  // 监听系统主题变化
  SystemThemeObserver.init(isCanChange: () async {
    final themeModeCache = await MyCache.getFile('themeMode');
    return themeModeCache == null ? true : false;
  });

  // 监听系统语言变化
  SystemLocaleObserver.init(getLangMode: () async {
    final localeCache = await MyCache.getFile('locale');
    final langMode = await localeCache?.readAsString();
    return langMode == null ? null : MyLangMode.fromString(langMode);
  });
}



