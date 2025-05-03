import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../views/views.dart';
import '../common.dart';

/// 第一次欢迎页面
class MiddlewareIndex extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // 跳转目标页面后的逻辑
    // 这里会请求一些数据
    Future.delayed(Duration.zero, () async => await _getData());

    if (UserController.to.isUsedApp.isEmpty) {
      return null;
    }

    if (UserController.to.userToken.isNotEmpty) {
      return const RouteSettings(name: MyRoutes.homeView);
    }

    return const RouteSettings(name: MyRoutes.loginView);
  }
}

Future<void> _getData() async {
  showMyLoading();
  await Future.delayed(MyConfig.time.pageTransition);
  await getEnvironment(
    onNext: () async {
      if (Get.isRegistered<LoginController>()) {
        final controller = Get.find<LoginController>();
        await controller.getPageData();
      } else if (Get.isRegistered<HomeController>()) {
        final controller = Get.find<HomeController>();
        await controller.getPageData();
      }
    }
  );
  hideMyLoading();
}
