import 'package:get/get.dart';

import 'controller.dart';

class UnknownBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut(() => UnknownController()),
      // 非懒加载
      // Bind.put(() => AnotherController()),
    ];
  }
}
