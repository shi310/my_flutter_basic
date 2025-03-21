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
      // title
      title: 'King Game',

      // 默认页面切换动画
      // 从右到左滑动
      defaultTransition: Transition.rightToLeftWithFade,
      // 动画市场 300 毫秒
      transitionDuration: const Duration(milliseconds: 300),

      // 路由
      getPages: MyPages.getPages,

      // 未知页面
      unknownRoute: MyPages.unknownRoute,

      // 启动页面
      initialRoute: MyRoutes.indexView,

      // APP字典，多语言切换
      // 字典
      translations: MyLang(),
      // 默认语言
      locale: Get.deviceLocale,
      // 备用语言
      fallbackLocale: MyLang.fallbackMode,

      // 系统字典，用来改变系统组件的语言
      localizationsDelegates: MyLang.localizationsDelegates,

      // 语言列表
      supportedLocales: MyLang.supportedLocales,

      // 主题
      theme: MyTheme().light,
      darkTheme: MyTheme().dark,
      themeMode: ThemeMode.light,

      // 顶层弹窗
      builder: (context, child) => MyAlert(key: MyAlert.globalKey, child: child),
    );
  }
}