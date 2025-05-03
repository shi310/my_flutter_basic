import 'package:get/get.dart';

import 'controller.dart';

class CustomerFaqListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerFaqListController>(() => CustomerFaqListController());
  }
}
