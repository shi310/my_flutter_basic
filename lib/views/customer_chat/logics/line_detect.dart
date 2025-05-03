import 'package:qichatsdk_flutter/qichatsdk_flutter.dart';
import 'package:get/get.dart';

import '../../../common/common.dart';
import '../index.dart';

class LineDetect implements LineDetectDelegate {
  final String lines;
  final int? tenantId;

  static LineDetect? _instance;

  factory LineDetect({
    required String lines,
    int? tenantId,
  }) {
    _instance ??= LineDetect._internal(
      lines: lines,
      tenantId: tenantId,
    );
    return _instance!;
  }

  LineDetect._internal({
    required this.lines,
    this.tenantId,
  }) {
    final lineDetect = LineDetectLib(
      lines,
      tenantId: tenantId,
    );
    lineDetect.delegate = this;
    lineDetect.getLine();
  }

  @override
  void lineError(error) {
    MyLogger.w('起聊初始化线路失败 -> ${error.message}');
    if (Get.isRegistered<CustomerChatController>()) {
      final controller = Get.find<CustomerChatController>();
      controller.title = error.message;
      controller.update([controller.getBuilderTitle]);
    }
  }

  @override
  void useTheLine(line) {
    MyLogger.w('起聊初始化线路成功 -> $line');
    if (Get.isRegistered<CustomerChatController>()) {
      final controller = Get.find<CustomerChatController>();
      final baseUrl = 'wss://$line/v1/gateway/h5';
      controller.initSDK(baseUrl: baseUrl);
    }
  }

  /// 可选：清除单例（用于重启、账号切换等）
  void reset() {
    _instance = null;
  }
}