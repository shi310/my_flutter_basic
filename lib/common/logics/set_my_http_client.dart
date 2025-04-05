import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

import '../common.dart';
import 'package:my_device_info/my_device_info.dart';

Future<void> setMyHttpClient() async {
  if (UserController.to.baseUrlList.isEmpty) {
    MyLogger.w('传入的链接组为空，无法配置Dio...');
    return;
  }

  if (UserController.to.myHttpClient != null) {
    MyLogger.w('MyHttpClient 已经初始化...');
    return;
  }

  final info = await MyDeviceInfo.getDeviceInfo();

  UserController.to.myHttpClient = MyHttpClient(
    urls: UserController.to.baseUrlList,
    timeout: MyConfig.time.out,
    headers: _headers(info),
    onResponse: _onResponse,
    onConnectError: _onConnectError,
    code: 0,
  );
}

Future<dynamic> _onConnectError(Response<dynamic>? response) async {
  showMyDialog(
    title: '连接超时',
    content: '请检查您的网络连接并重试',
    confirmText: '重试',
    onConfirm: () {
      UserController.to.mySocket?.reset();
    }
  );
}

Future<void> _onResponse(Request<Object?> options, Response<Object?> response) async {
  final json = response.bodyString?.toJson();
  if (json == null) {
    return;
  }
  final responseModel = ResponseModel.fromJson(json);
  if ([4].contains(responseModel.code)) {

  } else if ([2].contains(responseModel.code)) {

  }
}

Map<String, String> _headers(MyDeviceInfoModel info) {
  String device = '${info.brand}, ${info.id}, ${info.model}, ${info.systemVersion}';
  return {
    'x-token': UserController.to.userToken,
    'x-device': device,
    'x-timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
  };
}

