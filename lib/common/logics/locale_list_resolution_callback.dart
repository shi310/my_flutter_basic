import 'dart:ui';

import 'package:get/get.dart';

import '../common.dart';

/// 这是 GetX 的语言切换回调,
/// 它返回两个值 [系统语言列表] 和 [APP支持的语言列表]
///
/// [systemLocale] 可以监听到系统语言的变化,
/// [supportedLocales] 可以监听到APP支持的语言
///
/// 并根据系统语言的变化做一些业务逻辑
Locale? localeListResolutionCallback (List<Locale>? systemLocale, Iterable<Locale> supportedLocales) {
  Get.locale = MyLocale.defaultMode;
  return Get.locale;
  // MyLogger.w('系统语言列表：$systemLocale');
  // MyLogger.w('APP语言列表：$supportedLocales');
  // MyLocaleMode mode = MyLocaleMode.fromLocale(Get.deviceLocale ?? MyLocale.defaultMode);
  //
  // if (UserController.to.myLocaleMode != null) {
  //   mode = UserController.to.myLocaleMode!;
  // }
  //
  // Get.locale = mode.toLocale();
  // return mode.toLocale();
}