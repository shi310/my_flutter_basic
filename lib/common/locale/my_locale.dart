import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

part 'locale_keys.dart';
part 'key_en.dart';
part 'key_zh.dart';

class MyLocale extends Translations {
  // 默认语言模式
  static final defaultMode = MyLocaleMode.zh.toLocale();
  // 回退语言模式
  static final fallbackMode = MyLocaleMode.zh.toLocale();

  // 语言选项
  static const localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  // 支持语言
  static final supportedLocales = [
    MyLocaleMode.zh,
    MyLocaleMode.en,
  ].map((mode) => mode.toLocale()).toList();

  // 语言资源
  final _keys = {
    MyLocaleMode.zh.toLocaleTag(): zh,
    MyLocaleMode.en.toLocaleTag(): en,
  };

  @override
  Map<String, Map<String, String>> get keys => _keys;

  // 更改语言
  static Future<void> update({
    required MyLocaleMode mode,
    Future<dynamic> Function(MyLocaleMode mode)? onSuccess,
  }) async {
    await Get.updateLocale(mode.toLocale());
    await onSuccess?.call(mode);

    log('当前APP语言：${mode.toLocale()}');
    log('当前系统语言：${Get.deviceLocale}');
  }
}

enum MyLocaleMode {
  en('en'),
  zh('zh');

  final String mode;

  const MyLocaleMode(this.mode);

  static MyLocaleMode fromLocaleTag(String mode) {
    switch (mode) {
      case 'en':
        return MyLocaleMode.en;
      case 'zh':
        return MyLocaleMode.zh;
      default:
        return MyLocaleMode.zh;
    }
  }

  static MyLocaleMode fromLocale(Locale locale) {
    final languageCode = locale.languageCode;
    switch (languageCode) {
      case 'zh':
        return MyLocaleMode.zh;
      case 'en':
        return MyLocaleMode.en;
      default:
        return MyLocaleMode.zh;
    }
  }

  Locale toLocale() {
    switch (this) {
      case MyLocaleMode.en:
        return const Locale('en', 'US');
      case MyLocaleMode.zh:
        return const Locale('zh', 'CN');
    }
  }

  String toLocaleTag() {
    return mode;
  }
}