import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mgym/core/adaptive/adaptiv_layout_widget.dart';
import 'package:mgym/core/constants/colors.dart';
import 'package:mgym/core/constants/my_constants.dart';
import 'package:mgym/core/router/controller.dart';
import 'package:mgym/core/router/routes.dart';
import 'package:mgym/core/size_config/size_config.dart';
import 'package:mgym/features/domain/entities/meal_blan_entity.dart';
import 'package:mgym/features/domain/entities/user_entity.dart';
import 'package:mgym/features/presentation/controllers/auth_bloc/auth_bloc.dart';
import 'package:mgym/features/presentation/shared/custom_button/custom_button.dart';
import 'package:mgym/features/presentation/view/user_profile/user_profile_layout.dart';
part './screens/mopile_screen.dart';

class MealRecipeLayout extends StatelessWidget {
  const MealRecipeLayout(
      {super.key, required this.ingreduants, required this.user});
  final MealBlanEntity? ingreduants;
  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColours.black,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyColours.onPrimary,
          body: AdaptivLayoutWidget(
              mobileScreem: _MopileScreem(
                user: user,
                ingreduants: ingreduants,
              ),
              tabletScreen: _MopileScreem(
                user: user,
                ingreduants: ingreduants,
              ),
              desktopScreen: _MopileScreem(
                user: user,
                ingreduants: ingreduants,
              )),
        ),
      ),
    );
  }
}
