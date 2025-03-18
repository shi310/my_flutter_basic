import 'package:flutter/material.dart';

enum MyButtonStyle {
  // 无限长度的按钮
  filledButtonLong,

  // 无限长度的按钮
  filledButtonShort,

  // 有限长度的按钮
  textButton,

  // 图片按钮
  iconButton,

  // widget
  widget,
}

class MyButton extends StatefulWidget {
  const MyButton({
    super.key,
    required this.myButtonStyle,
    required this.onPressed,
    this.textColor,
    this.buttonColor,
    this.radius,
    this.fontSize,
    required this.child,
  });

  final MyButtonStyle myButtonStyle;
  final void Function()? onPressed;
  final Color? textColor;
  final Color? buttonColor;
  final double? radius;
  final double? fontSize;
  final Widget child;

  factory MyButton.filedLong({
    required void Function()? onPressed,
    required String text,
    Color? textColor,
    Color? color,
    double? radius,
  }) => MyButton(
    myButtonStyle: MyButtonStyle.filledButtonLong,
    onPressed: onPressed,
    textColor: textColor,
    buttonColor: color,
    radius: radius,
    child: FittedBox(child: Text(text)),
  );

  factory MyButton.floatLeft({
    required void Function()? onPressed,
    required String text,
    Color? textColor,
    Color? color,
    double? radius,
  }) => MyButton(
    myButtonStyle: MyButtonStyle.filledButtonLong,
    onPressed: onPressed,
    textColor: textColor,
    buttonColor: color,
    radius: radius,
    child: Container(alignment: Alignment.centerLeft, child: FittedBox(child: Text(text))),
  );

  factory MyButton.filedShort({
    required void Function()? onPressed,
    required String text,
    Color? textColor,
    Color? color,
    double? radius,
  }) => MyButton(
    myButtonStyle: MyButtonStyle.filledButtonShort,
    onPressed: onPressed,
    textColor: textColor,
    buttonColor: color,
    radius: radius,
    child: FittedBox(child: Text(text)),
  );

  factory MyButton.filedWidget({
    required void Function()? onPressed,
    required Widget child,
    Color? color,
    double? radius,
  }) => MyButton(
      myButtonStyle: MyButtonStyle.filledButtonShort,
      onPressed: onPressed,
      buttonColor: color,
      radius: radius,
      child: child
  );

  factory MyButton.text({
    required void Function()? onPressed,
    required String text,
    Color? textColor,
    double? fontSize,
    double? radius
  }) => MyButton(
    myButtonStyle: MyButtonStyle.textButton,
    onPressed: onPressed,
    textColor: textColor,
    fontSize: fontSize,
    radius: radius,
    child: FittedBox(child: Text(text)),
  );

  factory MyButton.icon({required void Function()? onPressed, required Widget icon}) => MyButton(
      myButtonStyle: MyButtonStyle.iconButton,
      onPressed: onPressed,
      child: icon
  );

  factory MyButton.widget({
    required void Function()? onPressed,
    required Widget child,
    Key? key,
  }) => MyButton(
    key: key,
    myButtonStyle: MyButtonStyle.widget,
    onPressed: onPressed,
    child: child,
  );

  @override
  MyButtonState createState() => MyButtonState();
}

class MyButtonState extends State<MyButton> {
  double opacity = 1.0;

  void changeOpacity(double value) {
    setState(() {
      opacity = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.myButtonStyle) {
      case MyButtonStyle.filledButtonLong:
        return FilledButton(
          onPressed: widget.onPressed,
          child: widget.child,
        );

      case MyButtonStyle.filledButtonShort:
        return FilledButton(
          onPressed: widget.onPressed,
          child: widget.child,
        );

      case MyButtonStyle.textButton:
        return TextButton(
          onPressed: widget.onPressed,
          child: widget.child,
        );

      case MyButtonStyle.iconButton:
        return IconButton(
          onPressed: widget.onPressed,
          icon: widget.child,
        );

      default:
        return GestureDetector(
          onTap: widget.onPressed,
          onTapDown: (_) => changeOpacity(0.5),
          onTapUp: (_) => changeOpacity(1),
          onTapCancel: () => changeOpacity(1),
          child: Opacity(
            opacity: opacity,
            child: widget.child,
          ),
        );
    }
  }
}