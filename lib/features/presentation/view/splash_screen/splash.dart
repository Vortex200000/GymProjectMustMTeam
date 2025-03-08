import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mgym/core/constants/colors.dart';

import 'package:mgym/core/router/routes.dart';
import 'package:mgym/features/presentation/controllers/auth_bloc/auth_bloc.dart';
import 'package:mgym/features/presentation/controllers/user_bloc/bloc/user_bloc.dart';
import 'package:mgym/features/presentation/shared/custom_message/custom_message.dart';
import 'package:mgym/features/presentation/view/complete_profile/complete_profile_layout.dart';
import 'package:mgym/features/presentation/view/trainee_view/trainee_view_layout.dart';

import '../../../../core/locator/setup_locator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  // void initState() {
  //   super.initState();
  //   // _startApp();
  // }

  // void _startApp() async {
  //   // await Future.delayed(Duration(seconds: 3));
  //   // Get.offNamed(Routes.splash2);
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<AuthBloc>()..add(CheckUserLoggedInEvent()),
      child: Container(
        color: Colors.black,
        child: SafeArea(
          child: Scaffold(
              backgroundColor: MyColours.onPrimary,
              body: Column(
                children: [Container(), const SplashListner()],
              )),
        ),
      ),
    );
  }
}

class SplashListner extends StatelessWidget {
  const SplashListner({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(listeners: [
      BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is CheckUserLoggedLoading) {
            const Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            );
          }
          if (state is CheckUserLoggedInError) {
            customMessage(
                context: context, lapel: state.errorMessage.toString());
          }
          if (state is UserNotLoggedIn) {
            Get.offNamed(Routes.splash2);
          }
          if (state is CheckUserLoggedSuccess) {
            // arguments: HomeLayout(user: UserCred(state.user) )
            userBloc(context).add(GetUserProfileEvent());
          }
        },
        child: SizedBox.shrink(),
      ),
      BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is GetUserProfileLoading) {
            // const Center(
            //   child: CircularProgressIndicator(
            //     color: Colors.grey,
            //   ),
            // );
          }
          if (state is GetUserProfileErr) {
            customMessage(
                context: context, lapel: state.errorMessage.toString());
          }
          if (state is GetUserProfileSuccess) {
            if (state.user.isSaved == false) {
              log('not saved');
              // Get.offNamed(Routes.completeProfile);
              Get.offNamed(Routes.completeProfile,
                  arguments: CompleteProfileLayout(
                    currentUser: state.user,
                  ));
            } else {
              log('saved profile ');
              Get.offNamed(Routes.homeRoute,
                  arguments: TrainneeView(
                    account: state.user,
                  ));
            }
          }
        },
        child: const SizedBox.shrink(),
      )
    ], child: const SizedBox.shrink());
  }
}
