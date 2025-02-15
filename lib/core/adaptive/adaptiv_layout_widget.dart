import 'package:flutter/material.dart';
import 'package:mgym/core/size_config/size_config.dart';

class AdaptivLayoutWidget extends StatelessWidget {
  const AdaptivLayoutWidget(
      {super.key,
      required this.mobileScreem,
      required this.tabletScreen,
      required this.desktopScreen});

  final Widget mobileScreem;
  final Widget tabletScreen;
  final Widget desktopScreen;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < SizeConfig.mobile) return mobileScreem;
        if (constraints.maxWidth < SizeConfig.tablet) return tabletScreen;
        return desktopScreen;
      },
    );
  }
}
