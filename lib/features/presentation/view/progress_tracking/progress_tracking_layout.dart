import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mgym/core/adaptive/adaptiv_layout_widget.dart';
import 'package:mgym/core/constants/colors.dart';
import 'package:mgym/core/constants/my_constants.dart';
import 'package:mgym/core/locator/setup_locator.dart';
import 'package:mgym/core/router/controller.dart';
import 'package:mgym/core/router/routes.dart';
import 'package:mgym/core/size_config/size_config.dart';
import 'package:mgym/features/data/data_source/remote_data/user_remote_data/user_remote_data.dart';
import 'package:mgym/features/domain/entities/user_entity.dart';
import 'package:mgym/features/presentation/controllers/auth_bloc/auth_bloc.dart';
import 'package:mgym/features/presentation/shared/custom_button/custom_button.dart';
import 'package:mgym/features/presentation/shared/custom_cached_image/custom_image_widget.dart';
import 'package:mgym/features/presentation/view/user_profile/user_profile_layout.dart';
part './screens/mobile_screen.dart';

class BorgressTrackingLayout extends StatelessWidget {
  const BorgressTrackingLayout({super.key, required this.account});
  final UserEntity account;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColours.black,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyColours.onPrimary,
          body: AdaptivLayoutWidget(
              mobileScreem: _MopileScreen(account),
              tabletScreen: _MopileScreen(account),
              desktopScreen: _MopileScreen(account)),
        ),
      ),
    );
  }
}
