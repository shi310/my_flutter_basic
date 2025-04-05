import 'package:flutter/foundation.dart';

import '../common.dart';

void setMySocket() {
  if (UserController.to.mySocket != null) {
    MyLogger.w('MyDio 已经初始化...');
    return;
  }
  UserController.to.mySocket = MySocket(
    token: UserController.to.userToken,
    urls: UserController.to.wssUrlList,
    isCanConnect: _isCanConnect,
    heartbeatMessage: _heartbeatMessage(),
    onMessageReceived: (message) => _onMessageReceived(message),
    onConnectError: _onConnectError,
  );
}

void _onConnectError() async {
  if (UserController.to.isWssCanConnection) {
    UserController.to.isWssCanConnection = false;
    await showMyDialog(
      title: '连接超时',
      content: '请检查您的网络连接并重试',
      confirmText: '重试',
      onConfirm: () {
        UserController.to.mySocket?.reset();
      }
    );
    UserController.to.isWssCanConnection = true;
  }
}

void _onMessageReceived(dynamic message) {
  final messageString = MyUint8.decode(message);
  final data = WebsocketMsgModel.fromJson(messageString.toJson());
  MyLogger.w(data.toJson().toString());

  if ([9].contains(data.type)) {
    UserController.to.mySocket?.lastHeartbeatResponseTime = DateTime.now();
  }
}

Future<bool> _isCanConnect() async {
  return true;
}

Uint8List _heartbeatMessage() {
  return MyUint8.encode({"type": 9});
}