import 'dart:async';
import 'dart:io';

import 'package:my_flutter_basic/common/common.dart';

Future<void> getBaseUrl({
  required List<String> urls,
  Future<dynamic> Function(String)? onSuccess,
  Future<dynamic> Function()? onError,
}) async {

  final client = HttpClient();
  final completer = Completer<String>();
  final tasks = <Future>[];


  for (var url in urls) {
    tasks.add(Future(() async {
      try {
        final uri = Uri.parse('$url${ApiPath.auth.health}');
        final request = await client.getUrl(uri).timeout(MyConfig.time.out);
        final response = await request.close();

        if (response.statusCode >= 200 && response.statusCode < 300) {
          MyLogger.w('$url 健康检测成功');
          if (!completer.isCompleted) {
            completer.complete(url);
          }
        } else {
          MyLogger.w('$url 健康检测失败 --> HTTP 状态码: ${response.statusCode}');
        }
      } catch (e) {
        MyLogger.w('$url 健康检测发生了错误 --> $e');
      }
    }));
  }

  String baseUrl = '';

  try {
    baseUrl = await completer.future.timeout(MyConfig.time.out);
  } catch (e) {
    MyLogger.w('健康检测超时或发生其他错误 --> $e');
  }

  client.close();

  if (baseUrl.isNotEmpty) {
    MyLogger.w('$baseUrl 被选定为 baseUrl');
    await onSuccess?.call(baseUrl);
  } else {
    MyLogger.w('baseUrl 配置未知错误');
    await onError?.call();
  }
}