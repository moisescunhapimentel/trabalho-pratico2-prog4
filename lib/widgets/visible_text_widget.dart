import 'package:flutter/material.dart';

class VisibleWidget extends StatelessWidget {
  final Widget child;
  final bool visible;

  const VisibleWidget({
    super.key,
    required this.child,
    required this.visible,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      maintainSize: false,
      child: child,
    );
  }
}
