import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import '../../common/common.dart';
import 'controller.dart';
import 'index.dart';

class CustomerChatView extends GetView<CustomerChatController> {
  const CustomerChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(child: Scaffold(
      appBar: builderMyAppBarNormalWidget(title: _buildAppBarTitle()),
      body: _buildBody(),
      backgroundColor: MyColors.white,
    ));
  }

  Widget _buildAppBarTitle() {
    return GetBuilder<CustomerChatController>(
      id: controller.getBuilderTitle,
      builder: (controller) {
        return Text(controller.title, style: TextStyle(
          fontSize: MyFontSize.titleSmall.value
        ));
      }
    );
  }

  Widget _buildBody() {
    return Column(children: [
      Expanded(child: _buildChatList()),
      _buildChatInput()
    ]);
  }

  Widget _buildChatList() {
    return GetBuilder<CustomerChatController>(
      id: controller.getBuilderChatList,
      builder: (controller) {
        return ListView.builder(
          padding: EdgeInsets.all(16),
          controller: controller.scrollController,
          // physics: AlwaysScrollableScrollPhysics(),
          // shrinkWrap: true,
          itemCount: controller.chatList.length,
          itemBuilder: (context, index) {
            return MyCard(
              margin: index == controller.chatList.length - 1 ? null : const EdgeInsets.only(bottom: 16),
              child: controller.chatList[index],
            );
          },
        );
      }
    );
  }

  Widget _buildChatInput() {
    // 按钮集合
    List<Widget> children = <Widget>[];

    // 这里全部是按钮的图标
    // 表情
    final qiEmoticons = MyCard(
      padding: EdgeInsets.all(10),
      child: Icon(Icons.mood, color: MyColors.iconDefault, size: 20),
    );
    // 拍照
    final qiCameraIcon = MyCard(
      padding: EdgeInsets.all(10),
      child: Icon(Icons.photo_camera, color: MyColors.iconDefault, size: 20),
    );
    // 相册
    final qiImage = MyCard(
      padding: EdgeInsets.all(10),
      child: Icon(Icons.image, color: MyColors.iconDefault, size: 20),
    );
    // 键盘
    final qiKeyboard = MyCard(
      padding: EdgeInsets.all(10),
      child: Icon(Icons.keyboard, color: MyColors.iconDefault, size: 20),
    );
    // 视频
    final qiVideo = MyCard(
      padding: EdgeInsets.all(10),
      child: Icon(Icons.videocam, color: MyColors.iconDefault, size: 20),
    );
    // 发送
    final qiSend = MyCard(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      color: MyColors.buttonDisable,
      borderRadius: BorderRadius.circular(8),
      child: Text(MyLanguage.send.tr, style: TextStyle(
        color: MyColors.onButtonDisable,
        fontSize: MyFontSize.body.value,
      )),
    );

    // 这里是聊天用到的一些按钮，例如表情、相册、拍照、视频等
    // 按钮-表情
    final buttonEmoticons = GetBuilder<CustomerChatController>(
      id: controller.getBuilderEmoticons,
      builder: (controller) {
        Widget child = qiEmoticons;
        if (controller.isShowEmoticons) {
          child = qiKeyboard;
        }
        return MyButton(borderRadius: BorderRadius.circular(8), onPressed: controller.onClickEmoticons, child: child);
      },
    );
    // 按钮-拍照
    final buttonCamera = MyButton(
      borderRadius: BorderRadius.circular(8),
      onPressed: controller.onClickCamera,
      child: qiCameraIcon,
    );
    // 按钮-相册
    final buttonImage = MyButton(
      borderRadius: BorderRadius.circular(8),
      onPressed: controller.onClickAlbum,
      child: qiImage,
    );
    // 按钮-视频
    final buttonVideo = MyButton(
      borderRadius: BorderRadius.circular(8),
      onPressed: controller.onClickVideo,
      child: qiVideo,
    );
    // 按钮-发送
    final buttonSend = GetBuilder<CustomerChatController>(
      id: controller.getBuilderButtonSend,
      builder: (controller) {
        if (!controller.isEnableButtonSend) {
          return qiSend;
        }  
        return MyButton(
          borderRadius: BorderRadius.circular(8),
          onPressed: controller.onClickSend,
          child: MyCard(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            color: MyColors.primary,
            borderRadius: BorderRadius.circular(8),
            child: Text(MyLanguage.send.tr, style: TextStyle(
              color: MyColors.onPrimary,
              fontSize: MyFontSize.body.value,
            )),
          ),
        );
      },
    );

    // 输入框
    final input = MyInput(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
      minLines: 1,
      maxLines: 5,
      controller: controller.inputTextController,
      focusNode: controller.inputTextFocusNode,
      color: MyColors.white,
      focusedBorder: MyStyles.inputBorderFocus,
      enabledBorder: MyStyles.inputBorder,
      keyboardType: TextInputType.emailAddress,
      disabledBorder: MyStyles.inputBorderDisable,
      style: MyStyles.inputText,
    );

    // 表情选择容器
    final emoticonsContainer = GetBuilder<CustomerChatController>(
      id: controller.getBuilderEmoticons,
      builder: (controller) {
        double height = 0;


        if (controller.isShowEmoticons) {
          height = 200;
        }

        return Container(
          constraints: BoxConstraints(maxHeight: 200),
          height: height,
          child: builderEmoticons(
            itemCount: controller.emoticons.length,
            emoticons: controller.emoticons,
            onPressed: (emoticon) => controller.inputTextController.text += emoticon,
          ),
        );
      },
    );

    return MyCard(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
      color: MyColors.itemCardBackground,
      child: SafeArea(child: FutureBuilder(
        future: controller.initCompleter.future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            children = [
              qiEmoticons,
              qiImage,
              qiCameraIcon,
              qiVideo,
              Spacer(),
              qiSend,
            ];
          } else {
            children = [
              buttonEmoticons,
              buttonImage,
              buttonCamera,
              buttonVideo,
              Spacer(),
              buttonSend,
            ];
          }

          return Column(children: [
            input,
            const SizedBox(height: 2),
            Row(children: children),
            const SizedBox(height: 2),
            emoticonsContainer,
          ]);
        },
      )),
    );
  }
}
