import 'package:my_flutter_basic/common/common.dart';
import 'package:get/get.dart';


Future<void> initLang() async {
  // 初始化语言
  final localeCache = await MyCache.getFile('locale');
  final localeString = await localeCache?.readAsString();

  MyLangMode mode = MyLangMode.fromLocale(Get.deviceLocale ?? MyLang.defaultMode);

  if (localeString != null) {
    mode = MyLangMode.fromString(localeString);
  }

  MyLang.update(mode: mode);
}