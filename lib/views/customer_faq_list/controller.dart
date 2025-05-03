import 'package:get/get.dart';

import '../../common/common.dart';

class CustomerFaqListController extends GetxController {
  // 页面参数
  // 本参数为必传，收不到参数会报错
  final CustomerFaqTypeModel arguments = Get.arguments;

  // 常见问题
  final customerFaqList = CustomerFaqListModel.empty();

  // 动态组件ID-body
  final String getBuilderBody = 'get_builder_body';

  // 获取请求客服数据的参数
  Future<void> getPageData() async {
    await Future.wait([
      customerFaqList.update(typeId: arguments.id),
    ]);
  }

  // 重新获取数据
  void retryGetPageData() {
    update([
      getBuilderBody,
    ]);
  }

  // 常见问题点击事件
  void onClickFaqItemClick(CustomerFaqInfoModel model) {
    Get.toNamed(MyRoutes.customerFaqInfoView, arguments: model);
  }
}
