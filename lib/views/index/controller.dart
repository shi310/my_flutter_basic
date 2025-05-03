import 'package:get/get.dart';

import '../../common/common.dart';
import '../login/index.dart';

class IndexController extends GetxController {
  // 欢迎页
  int pageIndex = 0;

  // 图片下标组件
  final getBuilderTabs = 'get_builder_tabs';

  // 更换页面
  void onPageChanged(int index) {
    pageIndex = index;
    update([getBuilderTabs]);
  }

  // 去登陆页面
  void onClickGoLoginView() {
    Get.offAllNamed(MyRoutes.loginView);
    UserController.to.isUsedApp = 'true';
    MyCache.putFile(MyConfig.shard.isUsedAppKey, UserController.to.isUsedApp.aesEncrypt(MyConfig.key.aesKey), time: const Duration(days: 365));
    getLoginViewData();
  }

  // 获取首页的数据
  Future<void> getLoginViewData() async {
    showMyLoading();
    await Future.delayed(MyConfig.time.pageTransition);
    final controller = Get.find<LoginController>();
    await controller.getPageData();
    hideMyLoading();
  }
}
