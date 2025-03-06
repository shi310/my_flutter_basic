import 'package:my_device_info/my_device_info_method.dart';
import 'package:my_flutter_basic/common/common.dart';

Future<void> initDeviceInfo() async {
  UserController.to.deviceInfo = await MyDeviceInfo.getDeviceInfo();

  UserController.to.shorebirdUpdater.readCurrentPatch().then((currentPatch) {
    MyLogger.w('The current patch number is: ${currentPatch?.number}');
    if (currentPatch != null && currentPatch.number > 0) {
      UserController.to.deviceInfo?.appVersion += '${currentPatch.number}';
    }
  });
}