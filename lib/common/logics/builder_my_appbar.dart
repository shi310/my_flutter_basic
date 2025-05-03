import 'package:flutter/material.dart';

import '../common.dart';

// appBar的文字样式
TextStyle _appBarTitle = TextStyle(color: MyColors.onaAppBar, fontSize: MyFontSize.bodyLarge.value);
// appBar的图标样式
IconThemeData _appBarIconThemeData = IconThemeData(color: MyColors.onaAppBar, size: 18);
// appBar的底部空间
Widget _flexibleSpace = Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        MyColors.appBarGradientStart,
        MyColors.appBarGradientEnd,
      ],
      stops: const [0.0, 1],
    ),
  ),
);

/// 普通的 appbar
/// 传文字就行
MyAppBar builderMyAppBarNormal({String? title, List<Widget>? actions}) => MyAppBar(
  backgroundColor: MyColors.background,
  title: title == null ? null : Text(title, maxLines: 1),
  titleTextStyle: _appBarTitle,
  iconTheme: _appBarIconThemeData,
  actions: actions,
  flexibleSpace: _flexibleSpace,
);

/// 普通的 APPBAR
/// 可以传入一个 widget
/// 自由度更高
MyAppBar builderMyAppBarNormalWidget({Widget? title, List<Widget>? actions}) => MyAppBar(
  backgroundColor: MyColors.background,
  title: title,
  titleTextStyle: _appBarTitle,
  iconTheme: _appBarIconThemeData,
  actions: actions,
  titleSpacing: 0,
  flexibleSpace: _flexibleSpace,
);

/// 透明的
MyAppBar builderMyAppBarTransparent({String? title, List<Widget>? actions}) => MyAppBar(
  backgroundColor: MyColors.background.withValues(alpha:  0),
  title: title == null ? null : Text(title, maxLines: 1),
  actions: actions,
  titleTextStyle: _appBarTitle,
  iconTheme: _appBarIconThemeData,
  elevation: 0,
);

/// 首页的banner
MyAppBar builderMyAppBarSpacer({Widget? title, Widget? flexibleSpace, PreferredSizeWidget? bottom}) => MyAppBar(
  backgroundColor: Colors.transparent,
  title: title,
  titleSpacing: 0,
  flexibleSpace: flexibleSpace,
  bottom: bottom,
  iconTheme: _appBarIconThemeData,
);

/// scan 专用（白色）
MyAppBar builderMyAppBarWhite({required String title}) {
  final whiteAppbarTitleTextStyle = TextStyle(
    color: MyColors.onPrimary,
    fontSize: MyFontSize.bodyLarge.value,
  );
  final whiteAppBarIconThemeData = IconThemeData(
    size: 18,
    color: MyColors.onPrimary,
  );
  return MyAppBar(
    backgroundColor: Colors.transparent,
    title: Text(title, maxLines: 1),
    titleTextStyle: whiteAppbarTitleTextStyle,
    iconTheme: whiteAppBarIconThemeData,
  );
}

/// 带颜色的 appbar
MyAppBar builderMyAppBarColor({String? title, Color? color, List<Widget>? actions}) {
  final whiteAppbarTitleTextStyle = TextStyle(
    color: MyColors.onPrimary,
    fontSize: MyFontSize.bodyLarge.value,
  );
  final whiteAppBarIconThemeData = IconThemeData(
    size: 18,
    color: MyColors.onPrimary,
  );
  return MyAppBar(
    backgroundColor: color,
    title: title == null ? null : Text(title, maxLines: 1),
    titleTextStyle: whiteAppbarTitleTextStyle,
    iconTheme: whiteAppBarIconThemeData,
    actions: actions,
    elevation: 0.0,
  );
}