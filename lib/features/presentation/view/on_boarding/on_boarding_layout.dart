import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mgym/core/adaptive/adaptiv_layout_widget.dart';
import 'package:mgym/core/constants/colors.dart';
import 'package:mgym/core/constants/my_constants.dart';
import 'package:mgym/core/router/routes.dart';
import 'package:mgym/core/size_config/size_config.dart';
import 'package:mgym/features/presentation/shared/custom_button/custom_button.dart';
import 'package:mgym/features/presentation/view/on_boarding/widgets/indicator.dart';
part './screens/mobile_screen.dart';
part './widgets/page_view_container.dart';
part './widgets/step.dart';
part './controller/on_boarding_controller.dart';

class OnBoardingLayout extends StatelessWidget {
  const OnBoardingLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColours.black,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyColours.onPrimary,
          body: AdaptivLayoutWidget(
              mobileScreem: _MobileScreen(),
              tabletScreen: _MobileScreen(),
              desktopScreen: _MobileScreen()),
        ),
      ),
    );
  }
}
