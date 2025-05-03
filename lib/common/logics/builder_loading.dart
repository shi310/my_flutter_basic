import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../common.dart';

Widget builderLoading({
  double? width,
  double? height,
  double? radius,
  EdgeInsetsGeometry? margin,
}) {
  return MyCard(
    width: width,
    height: height,
    margin: margin,
    borderRadius: BorderRadius.circular(radius ?? 8),
    child: LottieBuilder.asset(MyIcons.loading,
      width: width,
      height: height,
      fit: BoxFit.fill,
    ),
  );
}