import 'package:my_device_info/my_device_info.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MyAppInfoModel {
  MyAppInfoModel({
    this.deviceInfo,
    this.packageInfo,
    this.version,
  });

  MyDeviceInfoModel? deviceInfo;
  PackageInfo? packageInfo;
  String? version;
}