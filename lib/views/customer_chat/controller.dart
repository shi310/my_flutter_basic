import 'dart:async';
import 'dart:convert';

import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_gallery/common/common.dart';
import 'package:qichatsdk_flutter/qichatsdk_flutter.dart';

import '../../common/common.dart';
import '../views.dart';


class CustomerChatController extends GetxController {
  String token = '';
  String title = MyLanguage.connecting.tr;

  // 初始化等待方法
  final Completer<void> initCompleter = Completer<void>();

  final arguments = Get.arguments as CustomerChatViewArguments;
  List<Widget> chatList = [];

  final inputTextController = TextEditingController();
  final inputTextFocusNode = FocusNode();
  final ScrollController scrollController = ScrollController();

  // 定时器
  Timer? timerScrollOffset;
  // 线路检查器
  LineDetect? lineDetect;
  // 起聊ChatLib
  ChatLib? chatLib;
  // myHttpClient
  MyHttpClient? myHttpClient;
  // 最后发送成功的消息ID
  Int64? lastMsgId;
  // 消息队列
  // 会按照加入的顺序发送
  final taskQueue = MyTaskQueue();

  // QueryEntranceModel
  // 这是起聊的入口数据
  QueryEntranceModel queryEntrance = QueryEntranceModel.empty();
  // AssignWorkerModel
  // 这是分配的客服数据
  AssignWorkerModel assignWorker = AssignWorkerModel.empty();
  // 起聊的历史记录
  QichatHistory qichatHistory = QichatHistory.empty();
  // 自动回复
  AutoReplyModel autoReply = AutoReplyModel.empty();

  // 是否显示表情
  // 在表情和键盘按钮之间切换
  bool isShowEmoticons = false;
  // 是否锁定焦点
  bool isLockFocus = false;
  // 滚动偏移量
  double scrollOffset = 0;
  // 是否启用发送按钮
  bool isEnableButtonSend = false;
  // 表情包
  List<String> emoticons = [
    "😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "☺️", "😊",
    "😇", "🙂", "🙃", "😉", "😌", "😍", "🥰", "😘", "😗", "😙",
    "😚", "😋", "😛", "😝", "😜", "🤪", "🤨", "🧐", "🤓", "😎",
    "🤩", "🥳", "😏", "😒", "😞", "😔", "😟", "😕", "🙁", "😾",
    "😣", "😖", "😫", "😩", "🥺", "😢", "😭", "😤", "😠", "😡",
    "🤬", "🤯", "😳", "🥵", "🥶", "😱", "😨", "😰", "😥", "😓",
    "🤗", "🤔", "🤭", "🤫", "🤥", "😶", "😐", "😑", "😬", "🙄",
    "😯", "😦", "😧", "😮", "😲", "😴", "🤤", "😪", "😵", "🤐",
    "🥴", "🤢", "🤮", "🤧", "😷", "🤒", "🤕", "🤑", "🤠", "😈",
    "👿", "👹", "👺", "🤡", "💩", "👻", "💀", "☠️", "👽", "👾",
    "🤖", "🎃", "😺", "😸", "😹", "😻", "😼", "😽", "🙀", "😿",
    "👋", "🤚", "🖐", "✋", "🖖", "👌", "✌️", "🤞", "🤟", "🧀",
    "🤘", "🤙", "👈", "👉", "👆", "🖕", "👇", "☝️", "👍", "👎",
    "✊", "👊", "🤛", "🤜", "👏", "🙌", "👐", "🤲", "🙏", "✍️",
    "💅", "🤳", "💪","🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻",
    "🐼", "🐨", "🐯","🦁", "🐮", "🐷", "🐽", "🐸", "🐵", "🙈",
    "🙉", "🙊", "🐒","🐔", "🐧", "🐦", "🐤", "🐣", "🐥", "🦆",
    "🦅", "🦉", "🦇","🥓", "🍔", "🍟", "🍕", "🌭", "🥪", "🌮",
    "🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🥞",
    "🥝", "🍒", "🍑", "🥭", "🍍", "🥥", "🥑", "🍆", "🥔", "🥕",
    "🌽", "🌶️", "🥒", "🥬", "🥦", "🍄", "🥜", "🥖", "🥨", "🥯",
  ];

  // 动态组件ID：聊天列表
  final getBuilderChatList = 'getBuilderChatList';
  // 动态组件ID：表情按钮
  final getBuilderEmoticons = 'getBuilderEmoticons';
  // 动态组件ID：发送按钮
  final getBuilderButtonSend = 'getBuilderButtonSend';
  // 动态组件ID：页面的title
  final getBuilderTitle = 'getBuilderTitle';

  @override
  void onReady() async {
    super.onReady();
    MyLogger.w(arguments.toJson().toJsonString().formatJson());
    inputTextController.addListener(inputListener);
    inputTextFocusNode.addListener(focusListener);
    scrollController.addListener(scrollListener);
    startTimerScrollOffset();
    startInit();
  }

  @override
  void onClose() {
    inputTextController.removeListener(inputListener);
    inputTextFocusNode.removeListener(focusListener);
    scrollController.removeListener(scrollListener);
    stopTimerScrollOffset();
    chatLib?.dispose();
    lineDetect?.reset();
    super.onClose();
  }

  // 根据起聊的 cret 查找是否存在对应的token
  // 如果存在，则直接使用token
  // 如果不存在，则会使用 cret 初始化并生成新的token
  Future<void> getToken() async {
    final historyFile = await MyCache.getFile(MyConfig.shard.qiChatCustomerHistoryListKey);
    if (historyFile != null) {
      String historyString = await historyFile.readAsString();
      final history = CustomerHistoryModel.fromJson(jsonDecode(historyString));
      token = history.token;
    }
  }

  // 开始初始化
  Future<void> startInit() async {
    await selectLine();
  }

  // 选择线路
  Future<void> selectLine() async {
    lineDetect = LineDetect(
      lines: arguments.apiUrl,
      tenantId: arguments.tenantId,
    );
  }

  // 初始化SDK
  Future<void> initSDK({
    required String baseUrl,
  }) async {
    MyLogger.w('正在初始化起聊SDK...');
    await getToken();

    // Create an instance of ChatLib
    chatLib = ChatLib();

    // Create an instance of your listener
    final listener = QiChatListener();

    // Assign the listener to the ChatLib delegate
    chatLib?.delegate = listener;

    // Initialize the chat library with necessary parameters
    chatLib?.initialize(
      userId: arguments.userId ?? 0,
      cert: arguments.cret,
      token: token,
      baseUrl: baseUrl,
      sign: arguments.sign,
    );

    // Now the listener will receive the delegate events
    chatLib?.callWebSocket();

  }

  // 每200毫秒监听一次 scrollOffset 的值
  void startTimerScrollOffset() {
    timerScrollOffset = Timer.periodic(Duration(milliseconds: 200), (timer) {
      if (scrollController.hasClients && !scrollController.position.isScrollingNotifier.value) {
        isLockFocus = false;
      }
    });
  }

  // 停止计时
  void stopTimerScrollOffset() {
    timerScrollOffset?.cancel();
  }

  // 设置 myHttpClient
  void setMyHttpClient(MyHttpClient myHttpClient) {
    this.myHttpClient = myHttpClient;
  }

  // 表情点击事件
  void onClickEmoticons() async {
    isShowEmoticons = !isShowEmoticons;
    if (isShowEmoticons) {
      inputTextFocusNode.unfocus();
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await Future.delayed(Duration(milliseconds: 1000));
        moveTabToBottom();
      });
    } else {
      inputTextFocusNode.requestFocus();
    }
    update([getBuilderEmoticons]);
  }

  // 发送按钮点击事件
  void onClickSend() {
    final Future<String?> sendFuture = sendText();
    // 把发送文本加入发送队列
    taskQueue.addTask(() => sendFuture);
    // 下面是把本地的组件加到到对话窗口里
    // 分别获取用户头像和客服头像
    Widget avatar = Image.asset(MyIcons.defaultAvatar);
    if (Get.isRegistered<HomeController>()) {
      // 去首页拿到用户的数据，拿不到就没有头像
      final HomeController homeController = Get.find<HomeController>();
      avatar = MyImage(imageUrl: homeController.userInfo.user.avatarUrl);
    }

    chatList.add(CustomerChatViewMessageBox(
      alignType: AlignType.right,
      avatar: avatar,
      child: CustomerChatViewSendingTextBox(
        text: inputTextController.text,
        alignType: AlignType.right,
        future: sendFuture,
      ),
    ));

    update([getBuilderChatList]);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      moveTabToBottom();
    });
    inputTextController.clear();
    inputListener();
  }

  // 拍照按钮点击事件
  void onClickCamera() async {
    resetInput();
    showMyLoading();
    final file = await MyPicker.getImage(isCamera: true);
    hideMyLoading();
    if (file != null && Get.isRegistered<CustomerChatController>()) {
      final size = await MyPicker.getFileSize(file: file);
      final path = file.path;
      getMedia(path, size, MediaType.image);
    }
  }

  // 相册按钮点击事件
  void onClickAlbum() async {
    resetInput();
    showMyLoading();
    final file = await MyPicker.getMedia(isCamera: false);
    hideMyLoading();
    if (file != null && Get.isRegistered<CustomerChatController>()) {
      final fileType = file.path.split('.').last.toLowerCase();
      final size = await MyPicker.getFileSize(file: file);
      final path = file.path;

      if (['jpg', 'jpeg', 'png', 'gif', 'bmp'].contains(fileType)) {
        getMedia(path, size, MediaType.image);
      } else  if (['mov', 'mp4', 'avi'].contains(fileType)) {
        getMedia(path, size, MediaType.video);
      }
    }
  }

  // 视频按钮点击事件
  void onClickVideo() async {
    resetInput();
    showMyLoading();
    final file = await MyPicker.getVideo(isCamera: true, isBackCamera: true);
    hideMyLoading();
    if (file != null && Get.isRegistered<CustomerChatController>()) {
      final size = await MyPicker.getFileSize(file: file);
      final path = file.path;
      getMedia(path, size, MediaType.video);
    }
  }

  // 输入框监听
  void inputListener() {
    if (inputTextController.text.isEmpty) {
      isEnableButtonSend = false;
    } else {
      isEnableButtonSend = true;
    }

    update([getBuilderButtonSend]);
  }

  // 滚动监听
  void scrollListener() {
    scrollOffset = scrollController.offset;
    if (!isLockFocus) {
      inputTextFocusNode.unfocus();
      resetInput();
      isLockFocus = true;
    }
  }

  // 重置表情窗口和输入框焦点
  void resetInput() {
    inputTextFocusNode.unfocus();
    isShowEmoticons = false;
    update([getBuilderEmoticons]);
  }

  // 获取视频 / 图片
  void getMedia(String path, double size, MediaType mediaType) {
    showMyDialog(
      content: builderMediaFileBox(
        mediaType: mediaType,
        path: path,
      ),
      confirmText: MyLanguage.send.tr,
      cancelText: MyLanguage.cancel.tr,
      onConfirm: () => sendMedia(path, size, mediaType),
    );
  }

  // 发送媒体
  void sendMedia(String path, double size, MediaType mediaType) {


    if (mediaType == MediaType.image) {
      final Future<String> sendFuture = sendImage(path, size, mediaType);
      // 把发送图片加入发送队列
      taskQueue.addTask(() => sendFuture);
      final widget = CustomerChatViewMessageBox(
        alignType: AlignType.right,
        avatar: Container(
          color: Colors.pink,
        ),
        child: CustomerChatViewSendingMediaBox(
          mediaType: mediaType,
          future: sendFuture,
          path: path,
          alignType: AlignType.right,
        ),
      );
      chatList.add(widget);
      update([getBuilderChatList]);
    } else if (mediaType == MediaType.video) {
      final Future<String> sendFuture = sendVideo(path, size, mediaType);
      // 把发送视频加入发送队列
      taskQueue.addTask(() => sendFuture);
      final widget = CustomerChatViewMessageBox(
        avatar: Container(
          color: Colors.yellow,
        ),
        alignType: AlignType.right,
        child: CustomerChatViewSendingMediaBox(
          mediaType: mediaType,
          future: sendFuture,
          path: path,
          alignType: AlignType.right,
        ),
      );
      chatList.add(widget);
      update([getBuilderChatList]);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      moveTabToBottom();
    });
  }

  // 发送图片
  Future<String> sendImage(String path, double size, MediaType mediaType) async {
    await Future.delayed(Duration(seconds: 3));
    return '';
  }

  // 发送视频
  Future<String> sendVideo(String path, double size, MediaType mediaType) async {
    await Future.delayed(Duration(seconds: 3));
    return '';
  }

  // 发送文本
  Future<String?> sendText() async {
    // 消息发送等待方法
    Completer<String> sendCompleter = Completer<String>();
    Timer? sendTimer;

    // 每 10 毫秒检查一次lastMsgId
    sendTimer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      if (lastMsgId != null) {
        sendCompleter.complete(lastMsgId.toString());
        sendTimer?.cancel();
        lastMsgId = null;
      }
    });

    int consultId = 0;
    if (queryEntrance.consults.isNotEmpty) {
      consultId = queryEntrance.consults.first.consultId;
    }

    chatLib?.sendMessage(inputTextController.text, MessageFormat.MSG_TEXT, Int64(consultId));

    return sendCompleter.future;
  }


  // 移动窗体
  void moveTabToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (scrollController.hasClients) {
        stopTimerScrollOffset();
        isLockFocus = true;

        await scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
        await Future.delayed(Duration(milliseconds: 600));
        startTimerScrollOffset();
      }
    });
  }

  // 焦点监听
  void focusListener() async {
    if (inputTextFocusNode.hasFocus) {
      isShowEmoticons = false;
      update([getBuilderEmoticons]);
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await Future.delayed(Duration(milliseconds: 1000));
        moveTabToBottom();
      });
    }
  }
}
