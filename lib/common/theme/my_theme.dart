import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../common.dart';

class MyTheme {
  static final MyTheme _instance = MyTheme._internal();
  factory MyTheme() => _instance;
  MyTheme._internal();

  static Future<void> update({required MyThemeMode mode, Future<dynamic> Function(MyThemeMode mode)? onSuccess}) => _instance._update(mode: mode, onSuccess: onSuccess);
  static Future<void> setSystemUIOverlayStyle(Brightness brightness) => _instance._setSystemUIOverlayStyle(brightness);
  static void setPreferredOrientations() => _instance._setPreferredOrientations();
  static void removeNavigationBar() => _instance._removeNavigationBar();

  /// - 改变主题
  Future<void> _update({
    required MyThemeMode mode,
    Future<dynamic> Function(MyThemeMode mode)? onSuccess,
  }) async {
    Get.changeThemeMode(mode.toThemeMode());
    await _instance._setSystemUIOverlayStyle(mode.toBrightness());
    MyLogger.w('已更改主题 -> ${mode.toThemeModeTag()}');
    await onSuccess?.call(mode);
  }

  Future<void> _setSystemUIOverlayStyle(Brightness brightness) async {
    if (kIsWeb) return;
    if (!GetPlatform.isAndroid) return;

    // 设置系统导航栏样式
    final style = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: brightness,
      statusBarBrightness: brightness,
      systemNavigationBarColor: brightness == Brightness.light ? Colors.white : Colors.black,
      systemNavigationBarIconBrightness: brightness == Brightness.light ? Brightness.dark : Brightness.light,
      systemNavigationBarDividerColor: brightness == Brightness.light ? Colors.white : Colors.black,
    );

    // 设置系统导航栏模式
    // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    // 应用样式
    SystemChrome.setSystemUIOverlayStyle(style);
  }

  /// - 强制竖屏
  Future<void> _setPreferredOrientations() async {
    var option = [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown];
    await SystemChrome.setPreferredOrientations(option);
  }

  /// - 去掉安卓手机的底部导航栏
  Future<void> _removeNavigationBar() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
  }

  /// - 亮色主题
  ThemeData get light => ThemeData(
    platform: TargetPlatform.iOS,
    colorScheme: ColorScheme.fromSeed(
      primary: MyColors.primary,
      seedColor: MyColors.primary,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
  );

  /// - 暗色主题
  ThemeData get dark => ThemeData(
    platform: TargetPlatform.iOS,
    colorScheme: ColorScheme.fromSeed(
      primary: MyColors.primary,
      seedColor: MyColors.primary,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );
}

enum MyThemeMode {
  system('system'),
  light('light'),
  dark('dark');

  final String mode;

  const MyThemeMode(this.mode);

  static MyThemeMode from(String mode) {
    switch (mode) {
      case 'light':
        return MyThemeMode.light;
      case 'dark':
        return MyThemeMode.dark;
      default:
        return MyThemeMode.system;
    }
  }

  Brightness toBrightness() {
    switch (mode) {
      case 'light':
        return Brightness.light;
      case 'dark':
        return Brightness.dark;
      default:
        return Get.isPlatformDarkMode ? Brightness.dark : Brightness.light;
    }
  }

  ThemeMode toThemeMode() {
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  String toThemeModeTag() {
    return mode;
  }
}
