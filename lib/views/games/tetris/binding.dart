import 'package:get/get.dart';

import 'index.dart';

class TetrisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TetrisController>(() => TetrisController());
  }
}
