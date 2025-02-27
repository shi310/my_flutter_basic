import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common/common.dart';

void main() async {
  await initialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // 关闭debug角标
      // debugShowCheckedModeBanner: false,

      // title
      title: 'King Game',

      // 日志
      // enableLog: true,
      // logWriterCallback: MyLogger.write,

      // 默认页面切换动画
      defaultTransition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 300),

      // 路由
      getPages: MyPages.getPages,

      // 未知页面
      unknownRoute: MyPages.unknownRoute,

      // 启动页面
      initialRoute: MyRoutes.indexView,

      // APP字典，多语言切换
      translations: MyLang(), //字典
      locale: Get.deviceLocale, // 默认语言
      fallbackLocale: MyLang.fallbackMode, // 备用语言

      // 系统字典，用来改变系统组件的语言
      localizationsDelegates: MyLang.localizationsDelegates,

      // 语言列表
      supportedLocales: MyLang.supportedLocales,

      // 主题
      // theme: ConfigStore.to.isDarkMode ? AppTheme.dark : AppTheme.light,
      themeMode: ThemeMode.light,


      // 顶层弹窗
      builder: (context, child) => MyAlert(key: MyAlert.globalKey, child: child),
    );
  }
}