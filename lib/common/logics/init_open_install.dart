import 'package:openinstall_flutter_plugin/openinstall_flutter_plugin.dart';

import '../common.dart';

Future<void> initOpenInstall() async {
  UserController.to.openInstallFlutterPlugin = OpeninstallFlutterPlugin();

  UserController.to.openInstallFlutterPlugin?.init((Map<String, Object> data) async {
    String wakeUpLog = "wakeup result : channel=${data['channelCode']}, data=${data['bindData']}\n";
    MyLogger.w(wakeUpLog);
  });
}