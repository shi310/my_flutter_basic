import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common.dart';

Future<void> showMyDialog({
  Widget? title,
  Widget? content,
  bool isDismissible = true,
  Color? backgroundColor,
  String? confirmText,
  String? cancelText,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  double? margin,
  double? borderRadius,
}) async {
  final cancelButton = FilledButton(
    style: FilledButton.styleFrom(
      backgroundColor: MyColors.buttonCancel,
      foregroundColor: MyColors.onButtonCancel,
    ),
    child: Text(cancelText ?? MyLanguage.confirm.tr),
    onPressed: () {
      Get.back();
      onCancel?.call();
    },
  );

  final confirmButton = FilledButton(
    style: FilledButton.styleFrom(
      backgroundColor: MyColors.primary,
      foregroundColor: MyColors.onPrimary,
    ),
    child: Text(confirmText ?? MyLanguage.cancel.tr),
    onPressed: () async {
      Get.back(result: 'Dialog Result');
      onConfirm?.call();
    },
  );

  final column = Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      if (title != null) title,
      if (content != null && title != null) SizedBox(height: 16),
      if (content != null)
        Flexible(
          child: SingleChildScrollView(
            scrollDirection: Axis. vertical,
            child: ConstrainedBox(constraints: BoxConstraints(minHeight: 60), child: Center(child: content)),
          ),
        ),
      if ((title != null || content != null) && (confirmText != null || cancelText != null || onConfirm != null || onCancel != null)) SizedBox(height: 16),
      if (confirmText != null || cancelText != null || onConfirm != null || onCancel != null)
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (cancelText != null || onCancel != null) Expanded(child: cancelButton),
            if ((cancelText != null || onCancel != null) && (confirmText != null || onConfirm != null)) SizedBox(width: 10),
            if (confirmText != null || onConfirm != null) Expanded(child: confirmButton),
          ],
        ),
    ],
  );

  final child = Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          MyColors.appBarGradientStart,
          MyColors.appBarGradientEnd,
        ],
        stops: const [0.0, 0.33],
      ),
    ),
    padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
    child: column,
  );

  final result = await Get.generalDialog<dynamic>(
    barrierDismissible: isDismissible,
    barrierLabel: '',
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return SafeArea(
        child: Dialog(
          clipBehavior: Clip.antiAlias,
          insetPadding: margin == null ? const EdgeInsets.all(32) : EdgeInsets.all(margin),
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: borderRadius == null ? BorderRadius.circular(10) : BorderRadius.circular(borderRadius)),
          child: child,
        ),
      );
    },
  );

  if (isDismissible == false && result == null) {
    await showMyDialog(
      title: title,
      content: content,
      isDismissible: isDismissible,
      backgroundColor: backgroundColor,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
      margin: margin,
      borderRadius: borderRadius,
    );
  }
}
