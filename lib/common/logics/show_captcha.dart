import 'package:captcha_plugin_flutter/captcha_plugin_flutter.dart';
import 'package:get/get.dart';

import '../common.dart';

Future<void> showCaptcha({
  required String captchaId,
  void Function(String)? onSuccess,
  void Function()? onError,
  void Function()? onClose,
}) async {
  CaptchaPluginFlutter? captchaPlugin = CaptchaPluginFlutter();

  CaptchaPluginConfig styleConfig = CaptchaPluginConfig(
    radius: 10,
    capBarTextColor: "#25D4D0",
    capBarTextSize: 18,
    capBarTextWeight: "bold",
    borderColor: "#25D4D0",
    borderRadius:10,
    backgroundMoving: "#DC143C",
    executeBorderRadius:10,
    executeBackground: "#DC143C",
    capBarTextAlign: "center",
    capPaddingTop: 10,
    capPaddingRight: 10,
    capPaddingBottom: 10,
    capPaddingLeft: 10,
    paddingTop: 15,
    paddingBottom: 15
  );

  captchaPlugin.init({
    "captcha_id": captchaId,
    "is_debug": false,
    "dimAmount": 0.8,
    "is_touch_outside_disappear": true,
    "timeout": 8000,
    "is_hide_close_button": false,
    "use_default_fallback": true,
    "failed_max_retry_count": 4,
    "language_type": Get.locale?.toLanguageTag(),
    "is_close_button_bottom":true,
    "styleConfig":styleConfig.toJson(),
  });

  captchaPlugin.showCaptcha(
    onLoaded: () {
      MyLogger.w('网易行为式验证码初始化完毕...');
    },
    onSuccess: (dynamic data) {
      MyLogger.w('网易行为式验证成功...');
      MyLogger.w('$data');
      onSuccess?.call(data['validate']);
      captchaPlugin = null;
    },
    onClose: (dynamic data) {
      MyLogger.w('网易行为式验证退出...');
      onClose?.call();
      captchaPlugin = null;
    },
    onError: (dynamic data) {
      MyLogger.w('网易行为式验证出现错误...');
      onError?.call();
      captchaPlugin = null;
    },
  );
}