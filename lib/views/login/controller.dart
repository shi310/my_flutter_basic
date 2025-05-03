import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/common.dart';
import '../home/index.dart';

class LoginController extends GetxController {
  // 账号输入框控制器
  final accountTextController = TextEditingController();
  final accountFocusNode = FocusNode();

  // 密码输入框控制器
  final passwordTextController = TextEditingController();
  final passwordFocusNode = FocusNode();

  // 重复密码输入框控制器
  final rePasswordTextController = TextEditingController();
  final rePasswordFocusNode = FocusNode();

  // 手机输入框控制器
  final phoneTextController = TextEditingController();
  final phoneFocusNode = FocusNode();

  // 验证码输入框控制器
  final phoneCodeTextController = TextEditingController();
  final phoneCodeFocusNode = FocusNode();

  // 网易验证码业务ID
  final   captchaKey = CaptchaKeyModel.empty();

  // 动态组件ID-密码输入框
  final getBuilderInputPassword = 'get_builder_input_password';
  // 动态组件ID-重复密码输入框
  final getBuilderInputRePassword = 'get_builder_input_re_password';
  // 动态组件ID-验证码输入框
  final getBuilderInputPhoneCode = 'get_builder_input_phone_code';
  // 动态组件ID-标题【登陆/注册】
  final getBuilderTitle = 'get_builder_title';
  // 动态组件ID-记住密码按钮
  final getBuilderRememberAccount = 'get_builder_remember_account';
  // 动态组件ID-输入框部分的主题
  final getBuilderBody = 'get_builder_body';
  // 动态组件ID-登陆按钮
  final getBuilderButtonLogin = 'get_builder_button_login';
  // 动态组件ID-注册按钮
  final getBuilderButtonRegister = 'get_builder_button_register';
  // 动态组件ID-确认按钮/忘记密码按钮
  final getBuilderButtonConfirm = 'get_builder_button_confirm';
  // 动态组件ID-整个页面
  final getBuilderMain = 'get_builder_main';

  // 状态-是否隐藏密码
  bool isHidePassword = true;
  // 状态-是否隐藏重复密码
  bool isHideRePassword = true;
  // 状态-是否记住密码
  bool isRememberPassword = true;
  // 状态-是否启用发送验证码按钮
  bool isEnableButtonSendCode = false;
  // 状态-启用登陆按钮
  bool isEnableButtonLogin = false;
  // 状态-启用注册按钮
  bool isEnableButtonRegister = false;
  // 状态-启用忘记密码按钮
  bool isEnableButtonConfirm = false;
  // 状态-是否在加载中
  bool isLoading = false;
  // 状态-发送验证码倒计时
  int timeSendWait = 60;
  // 状态-登陆状态
  SignState signState = SignState.loginForPassword;
  // 状态-发送验证码按钮
  CodeState codeState = CodeState.toBeSend;

  // 时间控制器-发送验证码
  Timer? timerSendCodeWaiting;
  String? accountCache;
  String? phoneCache;

  @override
  void onReady() async {
    super.onReady();
    accountTextController.addListener(listener);
    phoneTextController.addListener(listener);
    passwordTextController.addListener(listener);
    rePasswordTextController.addListener(listener);
    phoneCodeTextController.addListener(listener);
    await getAccount();
  }

  @override
  void onClose() {
    accountTextController.removeListener(listener);
    phoneTextController.removeListener(listener);
    passwordTextController.removeListener(listener);
    rePasswordTextController.removeListener(listener);
    phoneCodeTextController.removeListener(listener);
    super.onClose();
  }

  Future<void> getPageData() async {
    await Future.wait([
      captchaKey.update(),
    ]);
  }

  // 输入框监听
  void listener() {
    // 发送验证码按钮是否启用
    if (phoneTextController.text.isEmpty) {
      isEnableButtonSendCode = false;
    } else {
      isEnableButtonSendCode = true;
    }

    updateGetBuilderInputPhoneCode();

    if (signState == SignState.loginForPassword) {
      if (accountTextController.text.isEmpty || passwordTextController.text.isEmpty) {
        isEnableButtonLogin = false;
      } else {
        isEnableButtonLogin = true;
      }
      updateGetBuilderButtonLogin();
    } else if (signState == SignState.loginForCode) {
      if (phoneTextController.text.isEmpty || phoneCodeTextController.text.isEmpty) {
        isEnableButtonLogin = false;
      } else {
        isEnableButtonLogin = true;
      }
      updateGetBuilderButtonLogin();
    } else if (signState == SignState.register) {
      if (accountTextController.text.isEmpty || passwordTextController.text.isEmpty || rePasswordTextController.text.isEmpty || phoneTextController.text.isEmpty || phoneCodeTextController.text.isEmpty) {
        isEnableButtonRegister = false;
      } else {
        isEnableButtonRegister = true;
      }
      updateGetBuilderButtonRegister();
    } else if (signState == SignState.forgotPassword) {
      if (passwordTextController.text.isEmpty || rePasswordTextController.text.isEmpty || phoneTextController.text.isEmpty || phoneCodeTextController.text.isEmpty) {
        isEnableButtonConfirm = false;
      } else {
        isEnableButtonConfirm = true;
      }
      updateGetBuilderButtonConfirm();
    }
  }

  // 刷新发送验证码按钮的状态
  void updateGetBuilderInputPhoneCode() {
    update([
      getBuilderInputPhoneCode,
    ]);
  }

  // 刷新登陆按钮
  void updateGetBuilderButtonLogin() {
    update([
      getBuilderButtonLogin,
    ]);
  }

  // 刷新登陆按钮
  void updateGetBuilderButtonRegister() {
    update([
      getBuilderButtonRegister,
    ]);
  }

  // 刷新忘记密码按钮
  void updateGetBuilderButtonConfirm() {
    update([
      getBuilderButtonConfirm,
    ]);
  }

  // 按钮事件-隐藏/显示密码
  void onClickShowHidePassword() {
    isHidePassword = !isHidePassword;
    update([
      getBuilderInputPassword,
    ]);
  }

  // 按钮事件-隐藏/显示重复密码输入框的文字
  void onClickShowHideRePassword() {
    isHideRePassword = !isHideRePassword;
    update([
      getBuilderInputRePassword,
    ]);
  }

  // 按钮事件-发送验证码
  void onClickSendCode() async {
    updateCodeState(CodeState.sending);
    updateGetBuilderInputPhoneCode();
    await sendPhoneCode();
  }

  // 按钮事件-切换到注册试图
  void onClickRegisterView() {
    updateSignState(SignState.register);
    update([
      getBuilderTitle,
      getBuilderBody,
    ]);
  }

  // 按钮事件-切换到登陆试图
  void onClickLoginView() {
    updateSignState(SignState.loginForPassword);
    update([
      getBuilderTitle,
      getBuilderBody,
    ]);
  }

  // 按钮事件-切换记住账号状态
  void onClickRememberAccount() {
    isRememberPassword = !isRememberPassword;
    update([
      getBuilderRememberAccount,
    ]);
  }

  // 按钮事件-切换到验证码登陆状态
  void onClickLoginForCodeView() {
    updateSignState(SignState.loginForCode);
    update([
      getBuilderBody,
    ]);
  }

  // 按钮事件-切换到密码登陆
  void onClickLoginForPasswordView() {
    updateSignState(SignState.loginForPassword);
    update([
      getBuilderBody,
    ]);
  }

  // 按钮事件-切换到忘记密码页面
  void onClickForgetPasswordView() {
    updateSignState(SignState.forgotPassword);
    update([
      getBuilderTitle,
      getBuilderBody,
    ]);
  }

  // 按钮事件-返回登陆状态
  void onClickGoBackLoginView() {
    onClickLoginView();
  }

  // 更新登陆状态
  void updateSignState(SignState state) {
    signState = state;
    Get.focusScope?.unfocus();
    clearInput();
    resetAccountInput();
    listener();
  }

  // 更新发送验证码按钮的状态
  void updateCodeState(CodeState state) {
    codeState = state;
  }

  // 清空输入框
  void clearInput() {
    accountTextController.clear();
    phoneTextController.clear();
    passwordTextController.clear();
    rePasswordTextController.clear();
    phoneCodeTextController.clear();
  }

  // 重置账号输入框
  void resetAccountInput() async {
    if (isRememberPassword && [SignState.loginForPassword, SignState.loginForCode].contains(signState)) {
      if (accountCache != null) {
        accountTextController.text = accountCache!;
      }

      if (phoneCache != null) {
        phoneTextController.text = phoneCache!;
      }
    }
  }

  // 获取储存的账号
  Future<void> getAccount() async {
    final account = await MyCache.getFile(MyConfig.shard.accountKey);
    if (account != null) {
      accountCache = await account.readAsString();
      accountCache = accountCache?.aesDecrypt(MyConfig.key.aesKey);
    }

    final phone = await MyCache.getFile(MyConfig.shard.phoneKey);
    if (phone != null) {
      phoneCache = await phone.readAsString();
      phoneCache = phoneCache?.aesDecrypt(MyConfig.key.aesKey);
    }

    resetAccountInput();
  }

  // 登陆
  void onClickLogin() {
    showMyBlock();
    Get.focusScope?.unfocus();
    showCaptcha(
      captchaId: captchaKey.captchaId,
      onSuccess: (value) async {
        if (value.isNotEmpty) {
          signState == SignState.loginForPassword
            ? loginForPassword(value)
            : loginForCode(value);
        }
      },
      onError: () {
        hideMyBlock();
      },

      onClose: () {
        hideMyBlock();
      }
    );
  }

  // 密码登陆
  Future<void> loginForPassword(String validate) async {
    showMyLoading();
    await UserController.to.myHttpClient?.post<UserInfoModel>(ApiPath.base.accountLogin,
      onSuccess: (code, msg, data) async {
        UserController.to.userToken = data.token;

        // 是否保存账号信息
        if (isRememberPassword) {
          MyCache.putFile(MyConfig.shard.accountKey, accountTextController.text.aesEncrypt(MyConfig.key.aesKey),
            time: const Duration(days: 365),
          );
        } else {
          MyCache.removeFile(MyConfig.shard.accountKey);
        }

        goHomeView();
      },
      onModel: (json) => UserInfoModel.fromJson(json),
      data: {
        "username": accountTextController.text,
        "password": passwordTextController.text.aesEncrypt(MyConfig.key.aesKey),
        'validate': validate,
      },
      onError: (response) async {
        showResponseError(response);
      }
    );
    hideMyLoading();
  }

  // 验证码登陆
  Future<void> loginForCode(String validate) async {
    showMyLoading();

    await UserController.to.myHttpClient?.post<UserInfoModel>(ApiPath.base.phoneLogin,
        onSuccess: (code, msg, data) async {
          UserController.to.userToken = data.token;

          // 保存手机号码
          if (isRememberPassword) {
            MyCache.putFile(MyConfig.shard.phoneKey, phoneTextController.text.aesEncrypt(MyConfig.key.aesKey),
              time: const Duration(days: 365),
            );
          } else {
            MyCache.removeFile(MyConfig.shard.phoneKey);
          }

          goHomeView();
        },
        onModel: (json) => UserInfoModel.fromJson(json),
        data: {
          "phone": phoneTextController.text,
          "verificationCode": phoneCodeTextController.text,
          'validate': validate,
        },
        onError: (response) async {
          showResponseError(response);
        }
    );

    hideMyLoading();
  }

  Future<void> register() async {
    showMyLoading();

    await UserController.to.myHttpClient?.post<UserInfoModel>(ApiPath.base.register,
        onSuccess: (code, msg, data) async {
          UserController.to.userToken = data.token;
          // 告诉 openInstall 注册成功
          // 用于 openInstall 统计注册
          UserController.to.openInstallFlutterPlugin?.reportRegister();
          goHomeView();
        },
        onModel: (json) => UserInfoModel.fromJson(json),
        data: {
          'username': accountTextController.text,
          'phone': phoneTextController.text,
          'password': passwordTextController.text.aesEncrypt(MyConfig.key.aesKey),
          'rePassword': rePasswordTextController.text.aesEncrypt(MyConfig.key.aesKey),
          'verificationCode': phoneCodeTextController.text,
        },
        onError: (response) async {
          showResponseError(response);
        }
    );

    hideMyLoading();
  }

  Future<void> forgetPassword() async {
    showMyLoading();

    await UserController.to.myHttpClient?.post(ApiPath.base.forgetPassword,
        onSuccess: (code, msg, data) async {
          onClickGoBackLoginView();
          MyAlert.showSnack(child: Text(msg));
        },
        data: {
          "phone": phoneTextController.text,
          "newPassword": passwordTextController.text.aesEncrypt(MyConfig.key.aesKey),
          "reNewPassword": rePasswordTextController.text.aesEncrypt(MyConfig.key.aesKey),
          "verificationCode": phoneCodeTextController.text,
        },
        onError: (response) async {
          showResponseError(response);
        }
    );

    hideMyLoading();
  }

  // 去首页
  void goHomeView() {
    Get.offAllNamed(MyRoutes.homeView);
    saveToken();
    getHomeViewData();
  }

  // 获取首页的数据
  Future<void> getHomeViewData() async {
    showMyLoading();
    await Future.delayed(MyConfig.time.pageTransition);
    final controller = Get.find<HomeController>();
    await controller.getPageData();
    hideMyLoading();
  }

  // 储存 token
  void saveToken() {
    MyCache.putFile(MyConfig.shard.userTokenKey,UserController.to.userToken.aesEncrypt(MyConfig.key.aesKey),
      time: const Duration(days: 5),
    );
  }

  // 储存账号
  void saveAccount() {
    MyCache.putFile(MyConfig.shard.accountKey,accountTextController.text.aesEncrypt(MyConfig.key.aesKey),
      time: Duration(days: 360),
    );
    accountCache = accountTextController.text;
  }

  // 清理账号
  void clearAccount() {
    MyCache.removeFile(MyConfig.shard.accountKey);
    accountCache = null;
  }

  // 注册
  void onClickRegister() {
    register();
  }

  // 找回密码
  void onClickConfirm() {
    forgetPassword();
  }

  // 发送验证码
  Future<void> sendPhoneCode() async {
    await UserController.to.myHttpClient?.post(ApiPath.base.sendSms,
      onSuccess: (code, msg, results) async {
        startTimer();
        showMySnack(child: Text('短信已成功发送'));
        updateCodeState(CodeState.waiting);
        updateGetBuilderInputPhoneCode();
      },
      data: {
        'phone': phoneTextController.text,
      },
      onError: (response) async {
        showResponseError(response);
        updateCodeState(CodeState.toBeSend);
        updateGetBuilderInputPhoneCode();
      },
    );
  }

  // 开始倒计时
  void startTimer() {
    stopTimer();
    timeSendWait = 60;
    timerSendCodeWaiting = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      timeSendWait--;
      updateGetBuilderInputPhoneCode();
      if (timeSendWait <= 0) {
        stopTimer();
        updateCodeState(CodeState.toBeSend);
        updateGetBuilderInputPhoneCode();
      }
    });
  }

  // 停止倒计时
  void stopTimer() {
    timerSendCodeWaiting?.cancel();
    timerSendCodeWaiting = null;
    timeSendWait = 60;
  }
}

// 登陆状态
enum SignState {
  loginForPassword,
  loginForCode,
  register,
  forgotPassword,
}

// 验证码状态
enum CodeState {
  toBeSend,
  sending,
  waiting,
}
