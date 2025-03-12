import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:my_flutter_basic/common/common.dart';



/// 第一次欢迎页面
class MiddlewareIndex extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    Future.delayed(Duration.zero, () async {
      showMyLoading();
      await getEnvironment();
      hideMyLoading();
    });

    // 这里可以请求一些公共数据和配置
    // 不需要 token 的接口
    // ...

    if (UserController.to.isUsedApp.isEmpty) {
      return null;
    }

    if (UserController.to.userToken.isNotEmpty) {
      // 这里请求首页的数据
      // 这个时候已经有token了
      // ...
      return const RouteSettings(name: MyRoutes.frameView);
    }

    // 这里是去登陆页面
    // 如果需要单独请求登陆页面的数据可以在这里请求
    // ...
    return const RouteSettings(name: MyRoutes.loginView);
  }
}
