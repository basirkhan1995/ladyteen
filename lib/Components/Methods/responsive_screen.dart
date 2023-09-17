import 'package:flutter/material.dart';

class ScreenLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  const ScreenLayout(
      {Key? key,
        required this.mobile,
        required this.tablet,
        required this.desktop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 480) {
          return mobile;
        } else if (constraints.maxWidth < 900) {
          return tablet;
        } else {
          return desktop;
        }
      },
    );
  }
}