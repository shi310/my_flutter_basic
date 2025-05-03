import 'package:get/get.dart';

import '../../common/common.dart';

class CustomerListController extends GetxController {
  // 页面参数
  // 本参数为必传，收不到参数会报错
  final CustomerListViewArguments arguments = Get.arguments;

  // 客服的数据
  final customerData = CustomerModel.empty();
  // 常见问题
  final customerFaqTypeList = CustomerFaqTypeListModel.empty();

  // 获取请求客服数据的参数
  Future<void> getPageData() async {
    final typeName = arguments.customerType == CustomerType.guest ? [4] : [2, 3];
    await Future.wait([
      customerData.update(typeName: typeName),
      customerFaqTypeList.update(),
    ]);
  }

  // 常见问题点击事件
  void onClickFaqItem(CustomerFaqTypeModel model) {
    Get.toNamed(MyRoutes.customerFaqListView, arguments: model);
  }

  // 客服列表点击事件
  void onClickCustomerItem(Customer model) async {
    final arguments = CustomerChatViewArguments(
      cret: model.cret,
      apiUrl: customerData.urlApi,
      imageUrl: customerData.urlImg,
      sign: customerData.sign,
      tenantId: customerData.chatUrl.toInt() ?? 0,
      userId: customerData.chatId,
    );

    Get.toNamed(MyRoutes.customerChatView, arguments: arguments);
  }
}
