import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mgym/core/adaptive/adaptiv_layout_widget.dart';
import 'package:mgym/core/constants/colors.dart';
import 'package:mgym/core/constants/my_constants.dart';
import 'package:mgym/core/router/routes.dart';
import 'package:mgym/core/size_config/size_config.dart';
import 'package:mgym/features/domain/entities/user_entity.dart';
import 'package:mgym/features/presentation/shared/blured_button/blurred_button.dart';
import 'package:mgym/features/presentation/view/complete_profile/widget/steper/steps.dart';
part './screens/mobile_screen.dart';
part './components/body_page.dart';
part './components/footer.dart';

class CompleteProfileLayout extends StatelessWidget {
  final UserEntity? currentUser;
  const CompleteProfileLayout({super.key, this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColours.black,
      child: SafeArea(
          child: Scaffold(
        backgroundColor: MyColours.onPrimary,
        body: AdaptivLayoutWidget(
            mobileScreem: _MobileScreen(currentUser),
            tabletScreen: _MobileScreen(currentUser),
            desktopScreen: _MobileScreen(currentUser)),
      )),
    );
  }
}
