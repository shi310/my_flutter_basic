// import 'package:get/get.dart';

import '../common.dart';


Future<void> initLocale() async {
  await MyLocale.update(mode: MyLocaleMode.zh);
  // MyLogger.w('正在初始化语言...');
  // // 初始化语言模式
  // MyLocaleMode mode = MyLocaleMode.fromLocale(Get.deviceLocale ?? MyLocale.defaultMode);
  //
  // // 获取语言配置
  // final localeCache = await MyCache.getFile(MyConfig.shard.localKey);
  // final localeTag = await localeCache?.readAsString();
  //
  // MyLogger.w('读取的语言配置 -> $localeTag...');
  //
  // if (localeTag != null) {
  //   mode = MyLocaleMode.fromLocaleTag(localeTag);
  //   UserController.to.myLocaleMode = mode;
  // }
  //
  // MyLogger.w('初始化语言模式 -> $mode');
  // await MyLocale.update(mode: mode);
}