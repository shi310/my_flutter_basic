import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/my_colors.dart';
import '../theme/my_icons.dart';
import '../widgets/my_button.dart';

// 构建输入框的图标
Widget builderInputIcon({
  Widget? child,
  double? size,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
      color: Colors.white.withAlpha(0),
    ),
    width: 40,
    height: 40,
    child: Center(
      child: SizedBox(
        width: size ?? 16,
        child: child,
      ),
    ),
  );
}

// 构建输入框的关闭图标
Widget builderInputCloseIcon({
  TextEditingController? controller
}) {
  return MyButton(
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(10),
      bottomRight: Radius.circular(10),
    ),
    onPressed: () {
      controller?.clear();
    },
    child: builderInputIcon(
      child: SvgPicture.asset(MyIcons.inputClear,
        colorFilter: ColorFilter.mode(MyColors.inputBorder, BlendMode.srcIn),
      ),
      size: 12,
    ),
  );
}
