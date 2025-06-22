
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mgym/core/adaptive/adaptiv_layout_widget.dart';
import 'package:mgym/core/constants/colors.dart';
import 'package:mgym/core/constants/my_constants.dart';
import 'package:mgym/core/locator/setup_locator.dart';
import 'package:mgym/core/router/controller.dart';
import 'package:mgym/core/router/routes.dart';
import 'package:mgym/core/size_config/size_config.dart';
import 'package:mgym/features/domain/entities/meal_blan_entity.dart';
import 'package:mgym/features/domain/entities/user_entity.dart';
import 'package:mgym/features/presentation/controllers/auth_bloc/auth_bloc.dart';
import 'package:mgym/features/presentation/controllers/nutration_bloc/nutration_bloc.dart';
import 'package:mgym/features/presentation/shared/custom_button/custom_button.dart';
import 'package:mgym/features/presentation/shared/slide_transition/slide.dart';
import 'package:mgym/features/presentation/view/meal_recipee/meal_recipee_layout.dart';
import 'package:mgym/features/presentation/view/nutration/controller/nutration_controller.dart';
import 'package:mgym/features/presentation/view/user_profile/user_profile_layout.dart';
part './screens/mopile_screend.dart';
part './components/header.dart';
part './components/body.dart';

class NutrationTap extends StatelessWidget {
  const NutrationTap({super.key, this.user});
  final UserEntity? user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<NutrationBloc>()..add(GetUserMealsEvent()),
      child: Container(
        color: MyColours.black,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: MyColours.onPrimary,
            body: AdaptivLayoutWidget(
                mobileScreem: _MobileScreen(user!),
                tabletScreen: _MobileScreen(user!),
                desktopScreen: _MobileScreen(user!)),
          ),
        ),
      ),
    );
  }
}
