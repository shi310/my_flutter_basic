import 'package:get/get.dart';

import 'controller.dart';

class CustomerListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerListController>(() => CustomerListController());
  }
}
