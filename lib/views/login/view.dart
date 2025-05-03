import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../common/common.dart';
import 'controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(child: Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      backgroundColor: MyColors.background,
    ));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final arguments = CustomerListViewArguments(
      customerType: CustomerType.guest,
    );
    return builderMyAppBarColor(
      color: MyColors.background.withValues(alpha: 0),
      actions: [builderCustomerButton(arguments: arguments)],
    );
  }

  Widget _buildBody(BuildContext context) {
    String version = 'V${UserController.to.myAppInfo?.version}';

    return SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      SvgPicture.asset(MyIcons.logo),
      const SizedBox(width: double.infinity, height: 4),
      Text('${MyLanguage.versionViewVersion.tr} $version'),
      const SizedBox(height: 10),
      _buildContent(context),
    ]));
  }

  Widget _buildContent(BuildContext context) {
    final borderRadius = BorderRadius.only(
      topRight: Radius.circular(10),
      bottomRight: Radius.circular(10),
    );

    // 账号输入框
    final inputAccount = MyInput(
      maxLines: 1,
      controller: controller.accountTextController,
      focusNode: controller.accountFocusNode,
      color: MyColors.input,
      focusedBorder: MyStyles.inputBorderFocus,
      enabledBorder: MyStyles.inputBorder,
      disabledBorder: MyStyles.inputBorderDisable,
      keyboardType: TextInputType.emailAddress,
      style: MyStyles.inputText,
      hintStyle: MyStyles.inputHint,
      hintText: MyLanguage.inputAccountHintText.tr,
      suffixIcon: builderInputCloseIcon(controller: controller.accountTextController),

      prefixIcon: builderInputIcon(
        child: SvgPicture.asset(
          MyIcons.inputPerson,
          colorFilter: ColorFilter.mode(MyColors.iconDefault, BlendMode.srcIn),
        ),
        size: 16,
      ),
    );

    // 密码输入框
    final inputPassword = GetBuilder<LoginController>(
      id: controller.getBuilderInputPassword,
      builder: (controller) {
        final suffixIcon = MyButton(
          borderRadius: borderRadius,
          onPressed: controller.onClickShowHidePassword,
          child: builderInputIcon(
            child: SvgPicture.asset(controller.isHidePassword ? MyIcons.inputShow : MyIcons.inputHide,
              colorFilter: ColorFilter.mode(MyColors.inputBorder, BlendMode.srcIn),
            ),
            size: 16,
          ),
        );
        return MyInput(
          maxLines: 1,
          controller: controller.passwordTextController,
          focusNode: controller.passwordFocusNode,
          color: MyColors.input,
          focusedBorder: MyStyles.inputBorderFocus,
          keyboardType: TextInputType.emailAddress,
          enabledBorder: MyStyles.inputBorder,
          disabledBorder: MyStyles.inputBorderDisable,
          obscureText: controller.isHidePassword,
          style: MyStyles.inputText,
          hintStyle: MyStyles.inputHint,
          hintText: MyLanguage.inputPasswordHintText.tr,
          suffixIcon: suffixIcon,
          prefixIcon: builderInputIcon(
            child: SvgPicture.asset(MyIcons.inputPassword,
              colorFilter: ColorFilter.mode(MyColors.iconDefault, BlendMode.srcIn),
            ),
            size: 19,
          ),
        );
      },
    );

    // 重复密码
    final inputRePassword = GetBuilder<LoginController>(
      id: controller.getBuilderInputRePassword,
      builder: (controller) {
        final suffixIcon = MyButton(
          borderRadius: borderRadius,
          onPressed: controller.onClickShowHideRePassword,
          child: builderInputIcon(
            child: SvgPicture.asset(controller.isHideRePassword ? MyIcons.inputShow : MyIcons.inputHide,
              colorFilter: ColorFilter.mode(MyColors.inputBorder, BlendMode.srcIn),
            ),
            size: 16,
          ),
        );
        return MyInput(
          maxLines: 1,
          controller: controller.rePasswordTextController,
          focusNode: controller.rePasswordFocusNode,
          color: MyColors.input,
          focusedBorder: MyStyles.inputBorderFocus,
          disabledBorder: MyStyles.inputBorderDisable,
          keyboardType: TextInputType.emailAddress,
          enabledBorder: MyStyles.inputBorder,
          obscureText: controller.isHideRePassword,
          style: MyStyles.inputText,
          hintStyle: MyStyles.inputHint,
          hintText: MyLanguage.inputRePasswordHintText.tr,
          suffixIcon: suffixIcon,
          prefixIcon: builderInputIcon(
            child: SvgPicture.asset(MyIcons.inputPassword,
              colorFilter: ColorFilter.mode(MyColors.iconDefault, BlendMode.srcIn),
            ),
            size: 19,
          ),
        );
      },
    );

    // 手机号
    final inputPhone = MyInput(
      maxLines: 1,
      controller: controller.phoneTextController,
      focusNode: controller.phoneFocusNode,
      color: MyColors.input,
      focusedBorder: MyStyles.inputBorderFocus,
      disabledBorder: MyStyles.inputBorderDisable,
      enabledBorder: MyStyles.inputBorder,
      style: MyStyles.inputText,
      hintStyle: MyStyles.inputHint,
      hintText: MyLanguage.inputPhoneHintText.tr,
      keyboardType: TextInputType.phone,
      suffixIcon: builderInputCloseIcon(controller: controller.phoneTextController),
      prefixIcon: builderInputIcon(
        child: SvgPicture.asset(MyIcons.inputPhone,
          colorFilter: ColorFilter.mode(MyColors.iconDefault, BlendMode.srcIn),
        ),
        size: 15,
      ),
    );

    // 手机验证码
    final inputPhoneCode = GetBuilder<LoginController>(
      id: controller.getBuilderInputPhoneCode,
      builder: (controller) {
        final child = IntrinsicWidth(
          child: MyCard(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            margin: EdgeInsets.all(4),
            borderRadius: BorderRadius.circular(8),
            color: controller.codeState == CodeState.toBeSend && controller.isEnableButtonSendCode ? MyColors.secondary : MyColors.buttonDisable,
            child: Center(
              child: controller.codeState != CodeState.sending
                ? Text( controller.codeState == CodeState.waiting ? controller.timeSendWait.toString() : MyLanguage.sendCode.tr,
                    style: TextStyle(
                      color: MyColors.white,
                      fontSize: MyFontSize.body.value,
                    ),
                  )
                : CupertinoActivityIndicator(color: MyColors.white),
            ),
          ),
        );

        final suffixIcon = controller.codeState == CodeState.toBeSend && controller.isEnableButtonSendCode
          ? MyButton(
              borderRadius: borderRadius,
              onPressed: controller.codeState == CodeState.toBeSend ? controller.onClickSendCode : null,
              child: child,
            )
          : child;

        return MyInput(
          maxLines: 1,
          controller: controller.phoneCodeTextController,
          keyboardType: TextInputType.number,
          focusNode: controller.phoneCodeFocusNode,
          disabledBorder: MyStyles.inputBorderDisable,
          color: MyColors.input,
          focusedBorder: MyStyles.inputBorderFocus,
          enabledBorder: MyStyles.inputBorder,
          style: MyStyles.inputText,
          hintStyle: MyStyles.inputHint,
          hintText: MyLanguage.inputPhoneCodeHintText.tr,
          suffixIcon: suffixIcon,
          prefixIcon: builderInputIcon(
            child: SvgPicture.asset(MyIcons.inputPhoneCode,
              colorFilter: ColorFilter.mode(MyColors.iconDefault, BlendMode.srcIn),
            ),
            size: 16,
          ),
        );
      },
    );

    // 记住密码
    final rememberAccount = GetBuilder<LoginController>(
      id: controller.getBuilderRememberAccount,
      builder: (controller) {
        return MyButton(
          onPressed: controller.onClickRememberAccount,
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            controller.isRememberPassword
              ? SvgPicture.asset(MyIcons.singleChecked)
              : SvgPicture.asset(MyIcons.singleUncheck),
            const SizedBox(width: 4),
            Text(MyLanguage.loginViewRememberAccount.tr,
              style: TextStyle(
                fontSize: MyFontSize.body.value,
              ),
            )
          ]),
        );
      },
    );

    // 登陆按钮
    final buttonLogin = SizedBox(
      width: double.infinity,
      child: GetBuilder<LoginController>(
        id: controller.getBuilderButtonLogin,
        builder: (controller) {
          return FilledButton(
            onPressed: controller.isEnableButtonLogin ? controller.onClickLogin : null,
            child: Text(MyLanguage.loginViewLogin.tr),
          );
        },
      ),
    );

    // 注册按钮
    final buttonRegister = SizedBox(
      width: double.infinity,
      child: GetBuilder<LoginController>(
        id: controller.getBuilderButtonRegister,
        builder: (controller) {
          return FilledButton(
            onPressed: controller.isEnableButtonRegister ? controller.onClickRegister : null,
            child: Text(MyLanguage.loginViewRegister.tr),
          );
        },
      ),
    );

    // 确认按钮
    final buttonConfirm = SizedBox(
      width: double.infinity,
      child: GetBuilder<LoginController>(
        id: controller.getBuilderButtonConfirm,
        builder: (controller) {
          return FilledButton(
            onPressed: controller.isEnableButtonConfirm ? controller.onClickConfirm : null,
            child: Text(MyLanguage.confirm.tr),
          );
        },
      ),
    );

    // 返回登陆按钮
    final buttonGoBackLogin = SizedBox(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: MyColors.black,
        ),
        onPressed: controller.onClickGoBackLoginView,
        child: Text(MyLanguage.loginViewGoBackLogin.tr),
      ),
    );

    // 密码登录按钮
    final buttonLoginForPassword = TextButton(
      onPressed: controller.onClickLoginForPasswordView,
      child: Text(MyLanguage.loginViewLoginForPassword.tr),
    );

    // 验证码登陆按钮
    final buttonLoginForCode = TextButton(
      onPressed: controller.onClickLoginForCodeView,
      child: Text(MyLanguage.loginViewLoginForCode.tr),
    );

    // 忘记密码按钮
    final buttonForgetPassword = TextButton(
      style: TextButton.styleFrom(
        foregroundColor: MyColors.black,
      ),
      onPressed: controller.onClickForgetPasswordView,
      child: Text(MyLanguage.loginViewForgotPassword.tr),
    );

    final boxLoginForPassword = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      inputAccount,
      const SizedBox(height: 4),
      inputPassword,
      const SizedBox(height: 8),
      rememberAccount,
      const SizedBox(height: 16),
      buttonLogin,
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        buttonLoginForCode,
        buttonForgetPassword,
      ]),
    ]);

    final boxLoginForCode = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      inputPhone,
      const SizedBox(height: 4),
      inputPhoneCode,
      const SizedBox(height: 8),
      rememberAccount,
      const SizedBox(height: 16),
      buttonLogin,
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        buttonLoginForPassword,
        buttonForgetPassword,
      ]),
    ]);

    final boxForgotPassword = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      inputPhone,
      const SizedBox(height: 4),
      inputPhoneCode,
      const SizedBox(height: 4),
      inputPassword,
      const SizedBox(height: 4),
      inputRePassword,
      const SizedBox(height: 16),
      buttonConfirm,
      buttonGoBackLogin,
    ]);

    final boxRegister = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      inputAccount,
      const SizedBox(height: 4),
      inputPassword,
      const SizedBox(height: 4),
      inputRePassword,
      const SizedBox(height: 4),
      inputPhone,
      const SizedBox(height: 4),
      inputPhoneCode,
      const SizedBox(height: 16),
      buttonRegister,
    ]);

    return MyCard(
      margin: const EdgeInsets.all(20),
      color: MyColors.cardBackground,
      borderRadius: BorderRadius.circular(20),
      child: Column(children: [
        _buildTitle(context),
        Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: GetBuilder<LoginController>(
            id: controller.getBuilderBody,
            builder: (controller) {

              if (controller.signState == SignState.register) {
                return boxRegister;
              }
              if (controller.signState == SignState.loginForCode) {
                return boxLoginForCode;
              }
              if (controller.signState == SignState.forgotPassword) {
                return boxForgotPassword;
              }
              return boxLoginForPassword;
            },
          ),
        ),
      ]),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return GetBuilder<LoginController>(
      id: controller.getBuilderTitle,
      builder: (controller) {
        final selectTextStyle = TextStyle(
          color: MyColors.primary,
          fontSize: MyFontSize.bodyLarge.value,
          fontWeight: FontWeight.w600,
        );

        if (controller.signState == SignState.forgotPassword) {
          return Stack(alignment: AlignmentDirectional.center, children: [
            const SizedBox(width: double.infinity, height: 60),
            Positioned(bottom: 4, child: Image.asset(MyIcons.loginTitleSelect, height: 20)),
            FittedBox(child: Text(MyLanguage.loginViewForgotPassword.tr, style: selectTextStyle)),
          ]);
        }  
        final loginTitleBackgroundLeft = SvgPicture.asset(MyIcons.loginTitleBackgroundLeft, height: 60, width: double.infinity, fit: BoxFit.fill);
        final loginTitleBackgroundRight = SvgPicture.asset(MyIcons.loginTitleBackgroundRight, height: 60, width: double.infinity, fit: BoxFit.fill);

        final background = [SignState.loginForPassword, SignState.loginForCode].contains(controller.signState)
            ? Row(children: [Expanded(child: loginTitleBackgroundLeft), const Expanded(child: SizedBox())])
            : Row(children: [const Expanded(child: SizedBox()), Expanded(child: loginTitleBackgroundRight)]);

        final leftSelect = Stack(alignment: AlignmentDirectional.center, children: [
          const SizedBox(width: double.infinity, height: 60),
          Positioned(bottom: 5, child: Image.asset(MyIcons.loginTitleSelect, height: 20)),
          FittedBox(child: Text(MyLanguage.loginViewTitleLogin.tr, style: selectTextStyle)),
        ]);

        final rightSelect = Stack(alignment: AlignmentDirectional.center, children: [
          const SizedBox(width: double.infinity, height: 60),
          Positioned(bottom: 5, child: Image.asset(MyIcons.loginTitleSelect, height: 20)),
          FittedBox(child: Text(MyLanguage.loginViewTitleRegister.tr, style: selectTextStyle)),
        ]);

        final leftUnselect = GestureDetector(
          onTap: controller.onClickLoginView,
          child: MyCard(
            child: Center(
              child: Text(MyLanguage.loginViewTitleLogin.tr,
                style: TextStyle(
                  fontSize: MyFontSize.bodyLarge.value,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        );

        final rightUnselect = GestureDetector(
          onTap: controller.onClickRegisterView,
          child: MyCard(
            child: Center(
              child: Text(MyLanguage.loginViewTitleRegister.tr,
                style: TextStyle(
                  fontSize: MyFontSize.bodyLarge.value,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        );

        final left = controller.signState == SignState.loginForPassword || controller.signState == SignState.loginForCode
            ? leftSelect
            : leftUnselect;

        final right = controller.signState == SignState.register
            ? rightSelect
            : rightUnselect;

        final content = Row(children: [Expanded(child: left), Expanded(child: right)]);

        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            background,
            Positioned.fill(child: content),
          ],
        );
      },
    );
  }
}
