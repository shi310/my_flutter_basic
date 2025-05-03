import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  const MyButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.debounceDuration = const Duration(milliseconds: 1000),
  });

  final void Function()? onPressed;
  final Widget child;
  final BorderRadiusGeometry? borderRadius;
  final Duration debounceDuration;

  @override
  MyButtonState createState() => MyButtonState();
}

class MyButtonState extends State<MyButton> {
  double opacity = 1.0;
  bool _inCooldown = false;

  void changeOpacity(double value) {
    if (mounted) {
      setState(() {
        opacity = value;
      });
    }
  }

  void _handleTap() {
    if (_inCooldown) return;

    widget.onPressed?.call();

    // 进入防抖状态
    _inCooldown = true;
    changeOpacity(0.5);

    Future.delayed(widget.debounceDuration, () {
      if (mounted) {
        _inCooldown = false;
        changeOpacity(1.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: widget.borderRadius,
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: _handleTap,
        onTapDown: (_) => !_inCooldown ? changeOpacity(0.5) : null,
        onTapUp: (_) => !_inCooldown ? changeOpacity(1.0) : null,
        onTapCancel: () => !_inCooldown ? changeOpacity(1.0) : null,
        child: Opacity(
          opacity: opacity,
          child: widget.child,
        ),
      ),
    );
  }
}