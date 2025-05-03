import 'package:get/get.dart';

import 'controller.dart';

class CustomerChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerChatController>(() => CustomerChatController());
  }
}
