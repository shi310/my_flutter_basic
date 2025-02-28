import 'dart:typed_data';

import 'package:my_flutter_basic/common/common.dart';

void setMyWss() {
  if (UserController.to.myWss != null) {
    MyLogger.w('MyDio 已经初始化...');
    return;
  }
  UserController.to.myWss = MyWss(
    urls: UserController.to.wssUrlList,
    isCanConnect: _isCanConnect,
    headers: _headers(),
    heartbeatMessage: _heartbeatMessage(),
    onMessageReceived: (message) => _onMessageReceived(message),
    onMaxRetryOut: _onMaxRetryOut
  );
}

void _onMaxRetryOut() async {
  UserController.to.isWssCanConnection = false;
  await showMyDialog(
    title: '连接超时',
    content: '请检查您的网络连接并重试',
    confirmText: '重试',
    onConfirm: () {
      UserController.to.myWss?.reset();
    }
  );
  UserController.to.isWssCanConnection = true;
}

void _onMessageReceived(dynamic message) {

}

Future<bool> _isCanConnect() async {
  return true;
}

Map<String, dynamic> _headers() {
  return {
    'x-token': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiMDAwMDAwMDAtMDAwMC0wMDAwLTAwMDAtMDAwMDAwMDAwMDAwIiwiSUQiOjQwLCJVc2VybmFtZSI6ImZ1Z3VpMDAzIiwiUGhvbmUiOiIxNTgwNTA2MDAwMyIsIkF1dGhvcml0eUlkIjowLCJBY2NvdW50VHlwZSI6MSwiSXNBdXRoIjozLCJCdWZmZXJUaW1lIjo4NjQwMCwiaXNzIjoicW1QbHVzIiwiYXVkIjpbIkdWQSJdLCJleHAiOjE3NDExNjk0NjIsIm5iZiI6MTc0MDU2NDY2Mn0.u46-KgZ2qX36TyprMNHjxMVE8B4rsQAdArERQDuo47c',
  };
}

Uint8List _heartbeatMessage() {
  return MyUint8.encode({"type": 9});
}