import 'package:get/get.dart';

import '../common.dart';



void setLangSystem() {
  MyLocaleMode mode = MyLocaleMode.fromLocale(Get.deviceLocale ?? MyLocale.defaultMode);
  MyLocale.update(mode: mode);
  MyCache.removeFile(MyConfig.shard.localKey);
  UserController.to.myLocaleMode = null;
}

void setLangZh() {
  MyLocale.update(mode: MyLocaleMode.zh);
  MyCache.putFile(MyConfig.shard.localKey, MyLocaleMode.zh.toLocaleTag());
  UserController.to.myLocaleMode = MyLocaleMode.zh;
}

void setLangEn() {
  MyLocale.update(mode: MyLocaleMode.en);
  MyCache.putFile(MyConfig.shard.localKey, MyLocaleMode.en.toLocaleTag());
  UserController.to.myLocaleMode = MyLocaleMode.en;
}