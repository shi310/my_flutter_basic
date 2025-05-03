import '../common.dart';

void setThemeLight() {
  MyTheme.update(mode: MyThemeMode.light);
  MyCache.putFile(MyConfig.shard.themeModeKey, MyThemeMode.light.toThemeModeTag());
  UserController.to.myThemeMode = MyThemeMode.light;
}

void setThemeDark() {
  MyTheme.update(mode: MyThemeMode.dark);
  MyCache.putFile(MyConfig.shard.themeModeKey, MyThemeMode.dark.toThemeModeTag());
  UserController.to.myThemeMode = MyThemeMode.dark;
}

void setThemeSystem() {
  MyTheme.update(mode: MyThemeMode.system);
  MyCache.removeFile(MyConfig.shard.themeModeKey);
  UserController.to.myThemeMode = null;
}