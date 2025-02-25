import 'package:get/get.dart';

import 'controller.dart';

class IndexBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut(() => IndexController()),
      // 非懒加载
      // Bind.put(() => AnotherController()),
    ];
  }
}
