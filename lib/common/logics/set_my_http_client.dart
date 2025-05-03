import 'package:flutter/material.dart';
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
    onConnectError: onConnectError,
    code: 0,
  );
}

Future<void> onConnectError(Response<dynamic>? response) async {
  closeDialog();

  await showMyDialog(
    title: Text(MyLanguage.apiErrorTitle.tr, style: TextStyle(
      fontSize: MyFontSize.titleSmall.value,
      fontWeight: FontWeight.w600,
    )),
    content: Text(MyLanguage.apiErrorContent.tr, style: TextStyle(
      fontSize: MyFontSize.body.value,
    )),
    confirmText: MyLanguage.retry.tr,
    cancelText: MyLanguage.cancel.tr,
    onCancel: () {},
    onConfirm: () async {
      // 页面重载逻辑
      // 基本思路：
      // 1、获取当前路由和参数，参数不变
      // 2、需要配置 preventDuplicates: false，意思是相同的路由也会进行重复跳转
      // 3、Get.offNamed 跳转，销毁上一个路由，确保不会出现重复
      await Future.delayed(MyConfig.time.pageTransition);
      final route = Get.currentRoute;
      final arguments = Get.arguments;
      MyLogger.w('重新加载页面 --> $route');
      Get.offNamed(route, arguments: arguments, preventDuplicates: false);
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
    if (UserController.to.userToken.isNotEmpty)
      'x-token': UserController.to.userToken,
    'x-device': device,
    'x-timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
  };
}

