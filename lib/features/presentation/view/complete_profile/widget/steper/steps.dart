import 'package:flutter/material.dart';
import 'package:mgym/core/adaptive/adaptiv_layout_widget.dart';
import 'package:mgym/core/constants/colors.dart';
import 'package:mgym/core/router/controller.dart';
import 'package:mgym/core/size_config/size_config.dart';
import 'package:mgym/features/presentation/shared/blured_button/blurred_button.dart';
import 'package:mgym/features/presentation/view/complete_profile/widget/steper/controller.dart';
part 'body.dart';
part 'footer.dart';
part './header.dart';

class StebsLayout extends StatelessWidget {
  const StebsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
          child: Scaffold(
        backgroundColor: MyColours.onPrimary,
        body: AdaptivLayoutWidget(
            mobileScreem: _MobileScreen(),
            tabletScreen: _MobileScreen(),
            desktopScreen: _MobileScreen()),
      )),
    );
  }
}

class _MobileScreen extends StatefulWidget {
  const _MobileScreen();

  @override
  State<_MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<_MobileScreen> {
  final StepsController stepsController = StepsController();
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    stepsController.initializeController(pageController);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HeaderSteps(stepsController),
        _BodySteps(stepsController),
        _FooterSteps(stepsController),
      ],
    );
  }
}
