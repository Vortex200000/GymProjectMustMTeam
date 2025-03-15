import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mgym/core/adaptive/adaptiv_layout_widget.dart';
import 'package:mgym/core/constants/colors.dart';
import 'package:mgym/core/constants/my_constants.dart';
import 'package:mgym/core/router/controller.dart';
import 'package:mgym/core/size_config/size_config.dart';
import 'package:mgym/features/domain/entities/user_entity.dart';
import 'package:mgym/features/presentation/controllers/user_bloc/bloc/user_bloc.dart';
import 'package:mgym/features/presentation/shared/custom_button/custom_button.dart';
import 'package:mgym/features/presentation/shared/custom_cached_image/custom_image_widget.dart';
import 'package:mgym/features/presentation/shared/custom_text_form/custom_text_form.dart';
import 'package:mgym/features/presentation/shared/slide_transition/slide.dart';
import 'package:mgym/features/presentation/view/user_profile/controller/trainer_profile_controller.dart';
import 'package:mgym/features/presentation/view/user_profile/controller/trainer_profile_listenr.dart';
part './screens/mobile_screen.dart';

class UserProfileLayout extends StatelessWidget {
  const UserProfileLayout({super.key, this.user});
  final UserEntity? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColours.black,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyColours.onPrimary,
          body: AdaptivLayoutWidget(
              mobileScreem: _MobileScreen(user),
              tabletScreen: _MobileScreen(user),
              desktopScreen: _MobileScreen(user)),
        ),
      ),
    );
  }
}
