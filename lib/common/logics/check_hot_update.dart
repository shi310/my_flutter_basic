import 'dart:async';

import 'package:my_flutter_basic/common/common.dart';
import 'package:my_device_info/my_device_info.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

void startCheckingForHotUpdates() {
  stopCheckingForHotUpdates();
  UserController.to.timerHotUpdate = Timer.periodic(const Duration(minutes: 2), (timer) async {
    final status = await UserController.to.shorebirdUpdater.checkForUpdate();
    if (status == UpdateStatus.outdated) {
      await UserController.to.shorebirdUpdater.update();
      showMyDialog(
        title: '发现新版本',
        content: '需要重新启动APP以应用更新，是否现在重新启动并更新？',
        onConfirm: () => MyDeviceInfo.restartApp(
          notificationTitle: '重新启动APP',
          notificationBody: '点击这里重新启动APP'
        ),
      );
    }
  });
}

void stopCheckingForHotUpdates() {
  UserController.to.timerHotUpdate?.cancel();
  UserController.to.timerHotUpdate = null;
}