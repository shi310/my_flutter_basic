part of 'config.dart';

class _Time {
  // 接口请求超时
  final Duration out = const Duration(seconds: 10);
  // 上传请求超时
  final Duration outUpload = const Duration(minutes: 60);
  // 数据刷新的等待时间
  final Duration wait = const Duration(seconds: 2);
  // 心跳间隔
  final Duration heartbeat = const Duration(seconds: 10);
  // 页面切换动画时长
  final Duration pageTransition = const Duration(milliseconds: 300);
  // 防抖时长
  final Duration debounce = const Duration(seconds: 1);
  // 缓存时间 - 1天
  final Duration cacheOneDay = const Duration(days: 1);
}