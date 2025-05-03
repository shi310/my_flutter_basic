import 'package:get/get.dart';

import 'controller.dart';

class CustomerFaqInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerFaqInfoController>(() => CustomerFaqInfoController());
  }
}
