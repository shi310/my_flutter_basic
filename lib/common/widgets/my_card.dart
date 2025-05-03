import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  const MyCard({
    super.key,
    this.color,
    this.borderRadius,
    this.width,
    this.height,
    this.child,
    this.padding,
    this.margin,
    this.boxShadow,
    this.border,
    this.gradient,
    this.constraints,
  });

  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double? height;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? border;
  final Gradient? gradient;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: constraints,
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        shape: BoxShape.rectangle,
        boxShadow: boxShadow,
        border: border,
        gradient: gradient,
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}