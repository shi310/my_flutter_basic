import '../common.dart';

// 初始化APP数据
Future<void> initAppData() async {
  await _getIsUsedApp();
  await _getUserToken();
}

// 获取是否使用过APP
Future<void> _getIsUsedApp() async {
  final isUsedApp = await MyCache.getFile(MyConfig.shard.isUsedAppKey);
  if (isUsedApp != null) {
    String isUsedAppCache = await isUsedApp.readAsString();
    UserController.to.isUsedApp = isUsedAppCache.aesDecrypt(MyConfig.key.aesKey);
  }
}

// 获取用户token
Future<void> _getUserToken() async {
  final userToken = await MyCache.getFile(MyConfig.shard.userTokenKey);
  if (userToken != null) {
    String userTokenCache = await userToken.readAsString();
    UserController.to.userToken = userTokenCache.aesDecrypt(MyConfig.key.aesKey);
  }
}