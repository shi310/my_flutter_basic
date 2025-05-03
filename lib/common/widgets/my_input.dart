import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class MyInput extends StatelessWidget {
  const MyInput({
    super.key,
    this.controller,
    this.focusNode,
    this.maxLines,
    this.textInputAction,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.obscureText = false,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.onTap,
    this.autofocus = false,
    this.enabled,
    this.padding = const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
    this.color,
    this.textAlign = TextAlign.start,
    this.onChanged,
    this.errorText,
    this.maxLength,
    this.inputFormatters,
    this.enabledBorder,
    this.minLines,
    this.buildCounter,
    this.focusedBorder,
    this.errorBorder,
    this.disabledBorder,
    this.hintStyle,
    this.errorStyle,
    this.style,
    this.onSubmitted,
    this.cursorColor,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final bool obscureText;
  final BorderRadiusGeometry borderRadius;
  final void Function()? onTap;
  final bool autofocus;
  final bool? enabled;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final TextAlign textAlign;
  final void Function(String)? onChanged;
  final String? errorText;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? disabledBorder;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final TextStyle? style;
  final Color? cursorColor;
  final void Function(String)? onSubmitted;
  final Widget? Function(BuildContext, {required int currentLength, required bool isFocused, required int? maxLength})? buildCounter;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: textInputAction,
      scrollPadding: EdgeInsets.zero,
      maxLength: maxLength,
      focusNode: focusNode,
      controller: controller,
      onSubmitted: onSubmitted ?? (value) => Get.focusScope?.unfocus(),
      onChanged: onChanged,
      maxLines: maxLines,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      buildCounter: buildCounter,
      decoration: InputDecoration(
        fillColor: color,
        filled: true,
        isDense: true,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: padding,
        hintText: hintText,
        hintStyle: hintStyle,
        focusedBorder: focusedBorder,
        enabledBorder: enabledBorder,
        errorBorder: errorBorder,
        focusedErrorBorder: errorBorder,
        errorText: errorText,
        errorStyle: errorStyle,
        disabledBorder: disabledBorder,
      ),
      obscureText: obscureText,
      onTap: onTap,
      cursorColor: cursorColor,
      cursorWidth: 1.6,
      style: style,
      autofocus: autofocus,
      enabled: enabled,
      textAlign: textAlign,
      textAlignVertical: TextAlignVertical.center,
      minLines: minLines,
    );
  }
}