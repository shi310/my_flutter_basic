import 'package:get/get.dart';

class MyIcons {
  // svg
  static const String logo = 'assets/svg/logo.svg';
  static const  String customer = 'assets/svg/customer.svg';
  static const  String customerAvatar = 'assets/images/customer_avatar.png';
  static const  String defaultAvatar = 'assets/images/avatar_default.png';
  static const String right = 'assets/svg/right.svg';
  static const String singleChecked = 'assets/svg/single_checked.svg';
  static const String singleUncheck = 'assets/svg/single_uncheck.svg';
  static const String dataError = 'assets/svg/data_error.svg';
  static const String dataEmpty = 'assets/svg/data_empty.svg';
  static const String inputClear = 'assets/svg/input_clear.svg';
  static const String inputPerson = 'assets/svg/input_person.svg';
  static const String inputShow = 'assets/svg/input_show.svg';
  static const String inputHide = 'assets/svg/input_hide.svg';
  static const String inputPassword = 'assets/svg/input_password.svg';
  static const String inputPhone = 'assets/svg/input_phone.svg';
  static const String inputPhoneCode = 'assets/svg/input_phone_code.svg';
  static const String loginTitleBackgroundLeft = 'assets/svg/login_title_background_left.svg';
  static const String loginTitleBackgroundRight = 'assets/svg/login_title_background_right.svg';
  static const String helpHot = 'assets/svg/help_hot.svg';
  // 图片
  static const String welcome1 = 'assets/images/welcome_1.png';
  static const String welcome2 = 'assets/images/welcome_2.png';
  static String get loginTitleSelect => 'assets/images/${Get.isDarkMode ? 'dark' : 'light'}/login_title_select.png';

  // lottie
  static String get loading => 'assets/lottie/${Get.isDarkMode ? 'dark' : 'light'}/loading.zip';
}