import 'package:flutter/material.dart';

import '../utils/constants.dart';

typedef ResponsiveBuilder = Widget Function(BuildContext context);

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    required this.tablet,
  });

  final ResponsiveBuilder mobile;
  final ResponsiveBuilder tablet;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= AppConstants.mobileBreakpoint) {
      return tablet(context);
    }
    return mobile(context);
  }
}
