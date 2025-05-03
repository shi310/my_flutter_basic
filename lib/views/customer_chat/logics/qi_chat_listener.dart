import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qichatsdk_flutter/qichatsdk_flutter.dart';

import '../../../common/common.dart';
import '../index.dart';

class QiChatListener implements TeneasySDKDelegate {
  static final QiChatListener _instance = QiChatListener._internal();
  factory QiChatListener() => _instance;
  QiChatListener._internal();


  @override
  void receivedMsg(msg) {
    MyLogger.w("收到客服发来的消息: $msg");
    if (Get.isRegistered<CustomerChatController>()) {
      final controller = Get.find<CustomerChatController>();

      AlignType alignType = AlignType.left;
      Widget avatar = MyImage(imageUrl: controller.arguments.imageUrl + controller.assignWorker.avatar);

      Widget messageBox;

      if (msg.msgFmt == MessageFormat.MSG_IMG) {
        messageBox = CustomerChatViewHistoryMediaBox(
          mediaType: MediaType.image,
          url: controller.arguments.imageUrl + msg.image.uri,
          alignType: alignType,
        );
      } else if (msg.msgFmt == MessageFormat.MSG_VIDEO) {
        messageBox = CustomerChatViewHistoryMediaBox(
          mediaType: MediaType.video,
          url: controller.arguments.imageUrl + msg.video.uri,
          alignType: alignType,
        );
      } else {
        messageBox = CustomerChatViewHistoryTextBox(
          text: msg.content.data,
          alignType: alignType,
        );
      }

      controller.chatList.add(CustomerChatViewMessageBox(
        alignType: alignType,
        avatar: avatar,
        child: messageBox,
      ));

      controller.update([controller.getBuilderChatList]);
      controller.moveTabToBottom();
    }

  }

  @override
  void systemMsg(result) {
    MyLogger.w("系统消息: ${result.message}");
    if (Get.isRegistered<CustomerChatController>()) {
      final controller = Get.find<CustomerChatController>();
      controller.title = result.message;
      controller.update([controller.getBuilderTitle]);
    }
  }

  @override
  void connected(c) async {
    MyLogger.w("起聊连接成功 -> token: ${c.token}");
    if (Get.isRegistered<CustomerChatController>()) {
      final controller = Get.find<CustomerChatController>();
      controller.token = c.token;

      // 设置http请求
      setQichatHttpClient(token: c.token);
      // 请求入口数据
      await controller.queryEntrance.update(
        myHttpClient: controller.myHttpClient,
      );

      int consultId = 0;
      if (controller.queryEntrance.consults.isNotEmpty) {
        consultId = controller.queryEntrance.consults.first.consultId;
      }

      // 请求客服数据
      await controller.assignWorker.update(
        myHttpClient: controller.myHttpClient,
        data: {
          'consultId': consultId,
        }
      );

      // 设置页面的标题为客服名称
      controller.title = controller.assignWorker.nick;
      controller.update([controller.getBuilderTitle]);

      // 请求历史记录和自动回复
      await Future.wait([
        controller.qichatHistory.update(
          myHttpClient: controller.myHttpClient,
          data: {
            "chatId": 0,
            "count": 100,
            "withLastOne": true,
            "workerId": controller.assignWorker.workerId,
            "consultId": consultId,
          }
        ),
        controller.autoReply.update(
          myHttpClient: controller.myHttpClient,
          data: {
            "workerId": controller.assignWorker.workerId,
            "consultId": consultId,
          }
        )
      ]);

      // 把历史记录和自动回复加入到聊天窗口
      addHistoryToChatWindow();
      addAutoReplyToChatWindow();

      // 结束页面的等待
      controller.initCompleter.complete();
    }
  }

  @override
  void workChanged(msg) {
    MyLogger.w("客服更改为 -> Consult ID: ${msg.consultId}");
  }

  @override
  void msgDeleted(msg, payloadId, errMsg) {
    MyLogger.w("删除成功: ${msg.msgId} ");
  }

  @override
  void msgReceipt(msg, payloadId, errMsg) {
    MyLogger.w("收到回执 payloadId:$payloadId msgId: ${msg.msgId}");
    if (Get.isRegistered<CustomerChatController>()) {
      MyLogger.w("尝试完成 sendCompleter，msgId=${msg.msgId}");
      final controller = Get.find<CustomerChatController>();
      controller.lastMsgId = msg.msgId;
    }
  }
}
