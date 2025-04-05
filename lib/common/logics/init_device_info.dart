import 'package:my_device_info/my_device_info_method.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../common.dart';

Future<void> initDeviceInfo() async {
  final deviceInfo = await MyDeviceInfo.getDeviceInfo();
  final packageInfo = await PackageInfo.fromPlatform();

  UserController.to.myAppInfo = MyAppInfoModel(
    deviceInfo: deviceInfo,
    packageInfo: packageInfo,
    version: packageInfo.version,
  );

  UserController.to.shorebirdUpdater.readCurrentPatch().then((currentPatch) {
    MyLogger.w('当前补丁总数量: ${currentPatch?.number}');
    if (currentPatch != null && currentPatch.number > 0) {
      final version = '${UserController.to.myAppInfo?.packageInfo?.version}+${currentPatch.number}';
      UserController.to.myAppInfo?.version = version;
    }
  });
}