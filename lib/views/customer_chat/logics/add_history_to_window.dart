import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../common/common.dart';
import '../../home/index.dart';
import '../index.dart';

void addHistoryToChatWindow() {
  if (Get.isRegistered<CustomerChatController>()) {
    final controller = Get.find<CustomerChatController>();

    for (var e in controller.qichatHistory.list.reversed.toList()) {
      // CMessage.MessageFormat.MSG_TEXT
      // CMessage.MessageFormat.MSG_IMG
      // CMessage.MessageFormat.MSG_VIDEO

      // 头像
      // 分别获取用户头像和客服头像
      Widget avatar = Image.asset(MyIcons.defaultAvatar);
      // 用来区分消息是用户发的还是客服发的
      // 客服发的放左边
      // 用户发的放右边
      AlignType alignType = AlignType.left;

      if (e.sender == e.chatId) {
        // 用户发的消息
        alignType = AlignType.right;
        if (Get.isRegistered<HomeController>()) {
          // 去首页拿到用户的数据，拿不到就没有头像
          final HomeController homeController = Get.find<HomeController>();
          avatar = MyImage(imageUrl: homeController.userInfo.user.avatarUrl);
        }
      } else {
        // 客服发的消息
        alignType = AlignType.left;
        avatar = MyImage(imageUrl: controller.arguments.imageUrl + controller.assignWorker.avatar);
      }

      Widget messageBox;

      if (e.msgFmt == 'MSG_IMG') {
        messageBox = CustomerChatViewHistoryMediaBox(
          mediaType: MediaType.image,
          url: controller.arguments.imageUrl + e.image.uri,
          alignType: alignType,
        );
      } else if (e.msgFmt == 'MSG_VIDEO') {
        messageBox = CustomerChatViewHistoryMediaBox(
          mediaType: MediaType.video,
          url: controller.arguments.imageUrl + e.video.uri,
          alignType: alignType,
        );
      } else {
        messageBox = CustomerChatViewHistoryTextBox(
          text: e.content.data,
          alignType: alignType,
        );
      }

      controller.chatList.add(CustomerChatViewMessageBox(
        alignType: alignType,
        avatar: avatar,
        child: messageBox,
      ));
    }

    controller.update([controller.getBuilderChatList]);
    controller.moveTabToBottom();
  }
}