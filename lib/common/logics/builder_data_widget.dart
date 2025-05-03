import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../common.dart';

// 构建数据加载失败的widget
Widget builderDataErrorWidget({
  Color? textColor,
  double width = 60,
  double height = 60,
  double fontSize = 14,
  void Function()? onRetry,
}) {
  final errorIcon = SvgPicture.asset(MyIcons.dataError,
    width: width,
    height: height,
    fit: BoxFit.fill,
    colorFilter: ColorFilter.mode(MyColors.iconGrey, BlendMode.srcIn),
  );

  final errorText = Text(MyLanguage.dataError.tr, style: TextStyle(
      color: textColor,
      fontSize: fontSize
  ));

  final retryButton = SizedBox(
    height: 30,
    child: FilledButton(
      onPressed: onRetry,
      child: Text(MyLanguage.retry.tr),
    ),
  );

  return Column(children: [
    errorIcon,
    const SizedBox(height: 10),
    errorText,
    const SizedBox(height: 10),
    retryButton,
  ]);
}

// 构建数据为空的widget
Widget builderDataEmptyWidget({
  Color? textColor,
  double width = 60,
  double height = 60,
  double fontSize = 14,
}) {
  final errorIcon = SvgPicture.asset(MyIcons.dataEmpty,
    width: width,
    height: height,
    fit: BoxFit.fill,
    colorFilter: ColorFilter.mode(MyColors.iconGrey, BlendMode.srcIn),
  );

  final errorText = Text(MyLanguage.dataEmpty.tr, style: TextStyle(
      color: textColor,
      fontSize: fontSize
  ));

  return Column(children: [
    errorIcon,
    const SizedBox(height: 10),
    errorText,
  ]);
}