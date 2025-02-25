import 'package:get/get.dart';
import 'package:my_flutter_basic/common/common.dart';
import 'package:my_flutter_basic/views/views.dart';

class MyPages {
  // 未知页面
  static final unknownRoute = GetPage(
    name: MyRoutes.unknownView,
    page: () => const UnknownView(),
    binding: UnknownBinding(),
  );

  static final List<GetPage> getPages = [
    // 初始页面
    GetPage(
      name: MyRoutes.indexView,
      page: () => const IndexView(),
      binding: IndexBinding(),
      middlewares: [
        MiddlewareIndex(),
      ],
    ),

    // 登陆页面
    GetPage(
      name: MyRoutes.loginView,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
  ];
}
