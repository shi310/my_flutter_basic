import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_device_info/my_device_info.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

import '../common.dart';

void startCheckingForHotUpdates() {
  stopCheckingForHotUpdates();
  UserController.to.timerHotUpdate = Timer.periodic(const Duration(minutes: 2), (timer) async {
    final status = await UserController.to.shorebirdUpdater.checkForUpdate();
    if (status == UpdateStatus.outdated) {
      await UserController.to.shorebirdUpdater.update();
      showMyDialog(
        title: Text(MyLanguage.restartTitle.tr, style: TextStyle(
          fontSize: MyFontSize.titleSmall.value,
          fontWeight: FontWeight.w600,
        )),
        content: Text(MyLanguage.restartContent.tr, style: TextStyle(
          fontSize: MyFontSize.body.value,
        )),
        onConfirm: () => MyDeviceInfo.restartApp(
          notificationTitle: MyLanguage.restartNoticeTitle.tr,
          notificationBody: MyLanguage.restartNoticeContent.tr,
        ),
      );
    }
  });
}

void stopCheckingForHotUpdates() {
  UserController.to.timerHotUpdate?.cancel();
  UserController.to.timerHotUpdate = null;
}