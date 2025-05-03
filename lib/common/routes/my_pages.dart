import 'package:get/get.dart';
import '../../views/views.dart';
import '../common.dart';

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

    // 首页
    GetPage(
      name: MyRoutes.homeView,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),

    // 客服列表
    GetPage(
      name: MyRoutes.customerListView,
      page: () => const CustomerListView(),
      binding: CustomerListBinding(),
    ),

    // 客服常见问题列表
    GetPage(
      name: MyRoutes.customerFaqListView,
      page: () => const CustomerFaqListView(),
      binding: CustomerFaqListBinding(),
    ),

    // 客服常见问题详情
    GetPage(
      name: MyRoutes.customerFaqInfoView,
      page: () => const CustomerFaqInfoView(),
      binding: CustomerFaqInfoBinding(),
    ),

    // 客服对话页面
    GetPage(
      name: MyRoutes.customerChatView,
      page: () => const CustomerChatView(),
      binding: CustomerChatBinding(),
    ),
  ];
}
