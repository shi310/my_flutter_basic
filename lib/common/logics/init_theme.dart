
// import 'package:flutter/material.dart';

import '../common.dart';

Future<void> initTheme() async {
  await MyTheme.update(mode: MyThemeMode.light);
  // MyLogger.w('正在初始化主题...');
  //
  // // 初始化主题
  // final themeModeCache = await MyCache.getFile(MyConfig.shard.themeModeKey);
  // final themeModeTag = await themeModeCache?.readAsString();
  //
  // MyLogger.w('读取的主题配置 -> $themeModeTag...');
  //
  // if (themeModeTag != null) {
  //   final themeMode = MyThemeMode.from(themeModeTag);
  //   UserController.to.myThemeMode = themeMode;
  //   await MyTheme.update(mode: themeMode);
  // } else {
  //   await MyTheme.update(mode: MyThemeMode.system);
  // }
}