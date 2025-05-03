import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final double elevation;
  final ShapeBorder? shape;
  final TextTheme? textTheme;
  final bool centerTitle;
  final double? titleSpacing;
  final Color? backgroundColor;
  final Widget? flexibleSpace;
  final TextStyle? titleTextStyle;
  final IconThemeData? iconTheme;
  final PreferredSizeWidget? bottom;
  final SystemUiOverlayStyle? systemOverlayStyle;


  const MyAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.elevation = 0.0,
    this.shape,
    this.textTheme,
    this.centerTitle = true,
    this.titleSpacing,
    this.backgroundColor,
    this.flexibleSpace,
    this.iconTheme,
    this.titleTextStyle,
    this.bottom,
    this.systemOverlayStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleTextStyle: titleTextStyle,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      iconTheme: iconTheme,
      centerTitle: centerTitle,
      titleSpacing: titleSpacing,
      flexibleSpace: flexibleSpace,
      leading: leading,
      title: title,
      actions: actions,
      bottom: bottom,
      systemOverlayStyle: systemOverlayStyle,
      // leadingWidth: 40,
      scrolledUnderElevation: 0
    );
  }

  @override
  Size get preferredSize {
    final bottomHeight = bottom?.preferredSize.height ?? 0.0;
    return Size.fromHeight(kToolbarHeight + bottomHeight);
  }
}