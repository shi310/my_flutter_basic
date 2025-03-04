part of 'theme.dart';

class MyStyles {
  static TextStyle get inputHint => TextStyle(color: MyColors.inputHint, fontSize: 14);
  static TextStyle get inputText => TextStyle(color: MyColors.inputText, fontSize: 14);
  static TextStyle get inputError => TextStyle(color: MyColors.error, fontSize: 14);
  static TextStyle get inputBankTitle => TextStyle(color: MyColors.inputText, fontSize: 14);

  static TextStyle get label => TextStyle(color: MyColors.textDefault, fontSize: 14, height: 0);
  static TextStyle get labelSmall => TextStyle(color: MyColors.textDefault.withValues(alpha: 0.6), fontSize: 14, height: 0);
  static TextStyle get labelBig => TextStyle(color: MyColors.textDefault, fontSize: 16, height: 0);
  static TextStyle get labelBigger => TextStyle(color: MyColors.textDefault, fontSize: 18, height: 0);
  static TextStyle get labelBiggest => TextStyle(color: MyColors.textDefault, fontSize: 22, height: 0);

  static TextStyle get labelPrimary => TextStyle(color: MyColors.primary, fontSize: 14, height: 0);
  static TextStyle get labelPrimaryBig => TextStyle(color: MyColors.primary, fontSize: 16, height: 0);
  static TextStyle get labelPrimaryBigger => TextStyle(color: MyColors.primary, fontSize: 18, height: 0);
  static TextStyle get labelPrimaryBiggest => TextStyle(color: MyColors.primary, fontSize: 22, height: 0);

  static TextStyle get labelRed => TextStyle(color: MyColors.error, fontSize: 14);
  static TextStyle get labelRedBig => TextStyle(color: MyColors.error, fontSize: 16);
  static TextStyle get labelRedBigger => TextStyle(color: MyColors.error, fontSize: 18);
  static TextStyle get labelGreen => TextStyle(color: MyColors.secondary, fontSize: 14);
  static TextStyle get labelGreenBig => TextStyle(color: MyColors.secondary, fontSize: 16);
  static TextStyle get labelGreenBigger => TextStyle(color: MyColors.secondary, fontSize: 18);

  static TextStyle get labelLight => TextStyle(color: MyColors.light, fontSize: 14, height: 0);
  static TextStyle get labelLightBig => TextStyle(color: MyColors.light, fontSize: 16, height: 0);
  static TextStyle get labelLightBigger => TextStyle(color: MyColors.light, fontSize: 18, height: 0);
  static TextStyle get labelLightBiggest => TextStyle(color: MyColors.light, fontSize: 22, height: 0);

  static TextStyle get content => TextStyle(color: MyColors.textDefault, fontSize: 14, height: 1.5);
  static TextStyle get contentLight => TextStyle(color: MyColors.light, fontSize: 14, height: 1.5);
  static TextStyle get contentSmall => TextStyle(color: MyColors.textDefault.withValues(alpha: 0.6), fontSize: 14, height: 1.5);
  static TextStyle get contentBig => TextStyle(color: MyColors.textDefault, fontSize: 16, height: 1.5);
  static TextStyle get contentBigger => TextStyle(color: MyColors.textDefault, fontSize: 18, height: 1.5);
  static TextStyle get contentBiggest => TextStyle(color: MyColors.textDefault, fontSize: 22, height: 1.5);

  // appBar的文字样式
  static TextStyle get appBarTitle => TextStyle(color: MyColors.onaAppBar, fontSize: 18);
  IconThemeData get appBarIconThemeData => IconThemeData(color: MyColors.onaAppBar, size: 18);

  static TextStyle get buttonText => const TextStyle(fontSize: 14);

  // 长按钮的样式
  ButtonStyle getButtonFilledLong({Color? textColor, Color? buttonColor, double? radius}) => ButtonStyle(
    textStyle: WidgetStateProperty.all<TextStyle?>(buttonText),
    backgroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.pressed)) return MyColors.buttonPressed;
      if (states.contains(WidgetState.disabled)) return MyColors.buttonDisable;
      return buttonColor ?? MyColors.primary;
    }),
    foregroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.pressed)) return MyColors.onPrimary;
      if (states.contains(WidgetState.disabled)) return MyColors.onButtonDisable;
      return textColor ?? MyColors.onPrimary;
    }),
    minimumSize: WidgetStateProperty.all<Size>(const Size(double.infinity, 40)),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 10),
      ),
    ),
  );

  // 短按钮的样式
  ButtonStyle getButtonFilledShort({Color? textColor, Color? buttonColor, double? radius}) => ButtonStyle(
    textStyle: WidgetStateProperty.all<TextStyle?>(buttonText),
    backgroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.pressed)) return MyColors.buttonPressed;
      if (states.contains(WidgetState.disabled)) return MyColors.buttonDisable;
      return buttonColor ?? MyColors.primary;
    }),
    foregroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) return MyColors.onButtonDisable;
      return textColor ?? MyColors.onPrimary;
    }),
    shape: WidgetStateProperty.all<OutlinedBorder?>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 8)),),
  );

  // 文字按钮的样式
  ButtonStyle getButtonText({Color? textColor, double? fontSize, double? radius}) => TextButton.styleFrom(
    textStyle: TextStyle(
      fontSize: fontSize ?? 14,
      height: 0
    ),
    foregroundColor: textColor ?? MyColors.onBackground,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 8)),
  );
}
