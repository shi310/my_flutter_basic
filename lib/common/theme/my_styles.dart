import 'package:flutter/material.dart';

import 'my_colors.dart';

class MyStyles {
  // 输入框的 hintText 样式
  static TextStyle inputHint = TextStyle(color: MyColors.inputHint, fontSize: MyFontSize.body.value);
  // 输入框文本的样式
  static TextStyle inputText = TextStyle(color: MyColors.inputText, fontSize: MyFontSize.body.value);
  // 输入框文本的样式
  static TextStyle inputError = TextStyle(color: MyColors.error, fontSize: MyFontSize.body.value);
  // 输入框银行卡标题
  static TextStyle inputBankTitle = TextStyle(color: MyColors.inputText, fontSize: MyFontSize.body.value);

  // 获取焦点时的输入框边框样式
  static InputBorder inputBorderFocus = OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: MyColors.primary, width: 1),
  );

  // 正常情况下的输入框边框样式
  static InputBorder inputBorder = OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: MyColors.inputBorder, width: 1),
  );

  // 错误情况下的输入框边框样式
  static InputBorder inputBorderError = OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: MyColors.error, width: 1),
  );

  // 输入框禁用时的边框样式
  static InputBorder inputBorderDisable = OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: MyColors.inputBorder.withValues(alpha: 0), width: 1),
  );
}

enum MyFontSize {
  label(10.0),
  bodySmall(12.0),
  body(14.0),
  bodyLarge(16.0),
  titleSmall(18.0),
  title(20.0),
  titleLarge(22.0),
  headlineSmall(24.0),
  headline(26.0),
  headlineLarge(28.0),
  displaySmall(30.0),
  display(32.0),
  displayLarge(34.0);

  final double value;

  const MyFontSize(this.value);
}