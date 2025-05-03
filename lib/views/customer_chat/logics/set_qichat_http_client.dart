import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:uuid/uuid.dart';

import '../../../common/common.dart';
import '../controller.dart';

void setQichatHttpClient({
  required String token,
}) async {
  if (Get.isRegistered<CustomerChatController>()) {
    final controller = Get.find<CustomerChatController>();
    final MyHttpClient myHttpClient = MyHttpClient(
      urls: controller.arguments.apiUrl.split(','),
      timeout: MyConfig.time.out,
      headers: _headers(token),
      onResponse: _onResponse,
      onConnectError: onConnectError,
      code: 0,
    );
    controller.setMyHttpClient(myHttpClient);
  }
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

Map<String, String> _headers(String token) {
  return {
    'x-token': token,
    'x-trace-id': const Uuid().v4(),
  };
}