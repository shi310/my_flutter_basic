import 'package:my_flutter_basic/common/common.dart';
import 'package:my_device_info/my_device_info.dart';

Future<void> setMyDio() async {
  showMyLoading();
  await getBaseUrl(
    urls: UserController.to.baseUrlList,
    onSuccess: (baseUrl) async {
      await _setMyDio(baseUrl: baseUrl);
      showMyDialog(
        title: '配置成功',
        content: 'baseUrl：$baseUrl',
        onConfirm: () {},
        onCancel: () {},
      );
    },
    onError: () {
      showMyDialog(
        title: '与服务器连接失败',
        content: '请稍后在重试',
        confirmText: '重试',
        onConfirm: () => setMyDio(),
        onCancel: () {},
      );
    }
  );
  hideMyLoading();
}

Future<void> _setMyDio({
  required String baseUrl,
}) async {
  final info = await MyDeviceInfo.getDeviceInfo();
  String device = '${info.brand}, ${info.id}, ${info.model}, ${info.systemVersion}';
  UserController.to.myDio = MyDio(
    baseOptions: (option) => option.copyWith(
      baseUrl: baseUrl,
      connectTimeout: MyConfig.time.out,
      receiveTimeout: MyConfig.time.out,
      sendTimeout: MyConfig.time.out,
    ),
    headers: {
      'x-token': UserController.to.userToken,
      'x-device': device,
      'x-timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
    },
    onResponse: (response) async {
      if (response.data is Map<String, dynamic>) {
        final responseModel = ResponseModel.fromJson(response.data);
        if ([4].contains(responseModel.code)) {

        } else if ([2].contains(responseModel.code)) {

        }
      }
    },
    dioCode: 0,
  );
}

