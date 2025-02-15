import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mgym/core/adaptive/adaptiv_layout_widget.dart';
import 'package:mgym/core/constants/colors.dart';
import 'package:mgym/core/router/controller.dart';
import 'package:mgym/core/router/routes.dart';
import 'package:mgym/core/size_config/size_config.dart';
import 'package:mgym/features/presentation/controllers/auth_bloc/auth_bloc.dart';
import 'package:mgym/features/presentation/shared/custom_button/custom_button.dart';
import 'package:mgym/features/presentation/shared/custom_text_form/custom_text_form.dart';
import 'package:mgym/features/presentation/view/login/login_controller/login_provider.dart';
part './screens/mobile_screen.dart';
part './components/body_page.dart';
part './components/header_page.dart';

class LoginLayout extends StatelessWidget {
  const LoginLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
          child: Scaffold(
        backgroundColor: MyColours.onPrimary,
        body: AdaptivLayoutWidget(
            mobileScreem: const _MobileScreen(),
            tabletScreen: const _MobileScreen(),
            desktopScreen: const _MobileScreen()),
      )),
    );
  }
}
