import 'package:flutter/material.dart';
import 'package:mgym/core/adaptive/adaptiv_layout_widget.dart';
import 'package:mgym/core/constants/colors.dart';
import 'package:mgym/core/router/controller.dart';
import 'package:mgym/core/size_config/size_config.dart';
import 'package:mgym/features/domain/entities/user_entity.dart';
import 'package:mgym/features/presentation/shared/blured_button/blurred_button.dart';
import 'package:mgym/features/presentation/view/complete_profile/controller/controller.dart';
part 'body.dart';
part 'footer.dart';
part './header.dart';

class StebsLayout extends StatelessWidget {
  final UserEntity userCredential;
  const StebsLayout({super.key, required this.userCredential});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
          child: Scaffold(
        backgroundColor: MyColours.onPrimary,
        body: AdaptivLayoutWidget(
            mobileScreem: _MobileScreen(userCredential),
            tabletScreen: _MobileScreen(userCredential),
            desktopScreen: _MobileScreen(userCredential)),
      )),
    );
  }
}

class _MobileScreen extends StatefulWidget {
  final UserEntity userCredential;
  const _MobileScreen(this.userCredential);

  @override
  State<_MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<_MobileScreen> {
  final StepsController stepsController = StepsController();
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    stepsController.initializeController(pageController, widget.userCredential);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HeaderSteps(stepsController),
        _BodySteps(stepsController),
        // _FooterSteps(stepsController),
      ],
    );
  }
}
