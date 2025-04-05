import 'dart:async';
import 'dart:developer';
import 'dart:io';

import '../common.dart';


class MySocket {
  MySocket({
    required this.urls,
    required this.isCanConnect,
    required this.heartbeatMessage,
    required this.token,
    this.heartbeatSeconds = 10,
    this.onConnectError,
    this.onMessageReceived,

  });

  // 传参
  final List<String> urls;
  final void Function(dynamic)? onMessageReceived;
  final Future<bool> Function() isCanConnect;
  final void Function()? onConnectError;
  final dynamic heartbeatMessage;
  final int heartbeatSeconds;
  final String token;

  // WebSocket 连接对象
  WebSocket? _webSocketChannel;

  // 心跳定时器 和 发送心跳的时间
  Timer? _heartbeatTimer;

  // 连接状态
  // 是否主动断开用户主动断开连接
  // 如果是主动断开的，就不重连了
  bool _isClosedByUser = false;
  bool _isConnected = false;
  bool _isConnecting = false;

  // 当前的重连次数
  int _retryAttempts = 0;

  // index
  int _index = 0;

  // 连接过的 url 数量
  int _urlCount = 0;

  // 单个链接的重连次数
  final int _maxRetryCount = 1;

  // 最后收到服务器心跳返回的时间
  DateTime lastHeartbeatResponseTime = DateTime.now();

  // 连接
  Future<void> connect() async {
    _retryAttempts = 0;
    await _retryConnection();
  }

  // ws 重置到初始化状态
  Future<void> reset() async {
    await close();
    _retryAttempts = 0;
    _urlCount = 0;
    await _retryConnection();
  }

  // WebSocket 连接方法
  Future<void> _connectWebSocket() async {
    final url = '${urls[_index]}?X-token=$token';

    if (_isConnected) {
      log("⚠️ wss: $url 已经连接...");
      return;
    }

    if (_isConnecting) {
      log("⚠️ wss: $url 正在连接...️");
      return;
    }

    if (urls.isEmpty || urls[_index].isEmpty) {
      log("⚠️ wss 链接为空，无法链接...");
      return;
    }

    if (!await isCanConnect()) {
      log("⚠️ $url -> 当前状态不允许连接 ⚠️");
      return;
    }

    log("🔗 尝试连接 WebSocket: $url");
    _isConnecting = true;

    try {
      _webSocketChannel = await WebSocket.connect(url).timeout(MyConfig.time.out * 0.3);

      _onConnectionOpen();

      _webSocketChannel?.listen(_onMessageReceived,
        onError: _onConnectionError,
        onDone: _onConnectionDone,
        cancelOnError: true,
      );

    } catch (e) {
      log('❌ ${urls[_index]} 连接失败 -> : $e');
      _isConnecting = false;
      _isClosedByUser = false;
      await _retryConnection();
    }
  }

  void _cancelTimer(Timer? timer) {
    timer?.cancel();
    timer = null;
  }

  // 处理接收到的消息
  void _onMessageReceived(message) {
    onMessageReceived?.call(message);
  }

  // WebSocket 连接关闭时处理
  void _onConnectionDone() {
    log('❌❌❌❌❌ WebSocket: ${urls[_index]} 已经关闭 -- ${DateTime.now()}');
    _isConnected = false;
    _cancelTimer(_heartbeatTimer);
    if (!_isClosedByUser) connect();
  }

  // WebSocket 连接错误时处理
  void _onConnectionError(error, extraParam) {
    log('❌❌❌❌❌ WebSocket: ${urls[_index]} 连接错误 $error, $extraParam -- ${DateTime.now()}');
    _isConnected = false;
    _cancelTimer(_heartbeatTimer);
    if (!_isClosedByUser) connect();
  }

  void _onConnectionOpen() {
    _isConnected = true;
    _isClosedByUser = false;
    _isConnecting = false;
    _retryAttempts = 0;
    _urlCount = 0;
    lastHeartbeatResponseTime = DateTime.now();
    // send(heartbeatMessage);
    _sendHeartBeat();

    log('✅ WebSocket 连接成功: ${urls[_index]}');
  }

  // 重连机制
  Future<void> _retryConnection() async {
    if (_retryAttempts >= _maxRetryCount) {
      // log('🛑 ${urls[_index]} 达到最大重连次数');

      if (_urlCount == urls.length - 1) {
        onConnectError?.call();
      } else {
        _index = (_index + 1) % urls.length;
        _urlCount++;
        _retryAttempts = 0;
        connect();
      }
      return;
    }

    _retryAttempts++;

    if (await isCanConnect()) {
      await _connectWebSocket();
    } else {
      log('💥💥 无法重连: ${urls[_index]}，条件不满足 💥💥');
    }
  }

  // 发送心跳包
  void _sendHeartBeat() {
    _cancelTimer(_heartbeatTimer);
    if (!_isConnected) return;

    _heartbeatTimer = Timer.periodic(Duration(seconds: heartbeatSeconds), (timer) {
      if (_isConnected) {
        send(heartbeatMessage);
      } else {
        log('💔 WebSocket 未连接，停止发送心跳');
        _cancelTimer(_heartbeatTimer);
      }
    });
  }

  // 断开 WebSocket 连接
  Future<void> close() async {
    _isClosedByUser = true;
    _isConnected = false;
    _isConnecting = false;
    _cancelTimer(_heartbeatTimer);

    try {
      await _webSocketChannel?.close(1000, '客户端主动断开链接');
    } catch (e) {
      log('❌ WebSocket: ${urls[_index]} 关闭时发生错误: $e');
    } finally {
      _webSocketChannel = null;
    }
  }

  // 发送消息
  void send(data) {
    if (_isConnected && _webSocketChannel != null) {
      try {
        final time = DateTime.now();
        // 比较 time 和 lastHeartbeatResponseTime 的差值
        final timeDifference = time.difference(lastHeartbeatResponseTime).inSeconds;
        if (timeDifference > heartbeatSeconds * 2) {
          log('🙅💔🙅 WebSocket: ${urls[_index]} 未收到心跳包返回，疑似与服务器断开连接断 -- ${DateTime.now()}');
          close();
          _retryConnection();
          return;
        }
        _webSocketChannel?.add(data);
        log('💓 心跳包发送成功');
      } catch (e) {
        log('>>>>> 😔 消息发送失败（ ${DateTime.now()} ) --> $e');
        _retryConnection();
      }
    } else {
      log('>>>>> ❌ WebSocket 未连接，无法发送消息');
      _retryConnection();
    }
  }
}