import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mgym/core/constants/colors.dart';
import 'package:mgym/core/router/controller.dart';
import 'package:mgym/core/router/routes.dart';
import 'package:mgym/features/presentation/controllers/auth_bloc/auth_bloc.dart';
import 'package:mgym/features/presentation/controllers/user_bloc/bloc/user_bloc.dart';
import 'package:mgym/features/presentation/shared/custom_message/custom_message.dart';
import 'package:mgym/features/presentation/view/complete_profile/complete_profile_layout.dart';
import 'package:mgym/features/presentation/view/trainee_view/trainee_view_layout.dart';

class SignInProvider extends StatelessWidget {
  const SignInProvider({super.key, required this.builder});
  final Widget Function(AuthBloc, AuthState) builder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return builder(authBloc(context), state);
      },
    );
  }
}

class SignInListner extends StatelessWidget {
  const SignInListner({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is SignInLoading) {
              showDialog(
                context: context,
                builder: (context) => Center(
                  child: CircularProgressIndicator(
                    color: MyColours.onTerniary,
                  ),
                ),
              );
            }
            if (state is SignInFailure) {
              back;
              if (state.errorMessage ==
                  'The supplied auth credential is incorrect, malformed or has expired.') {
                customMessage(
                    context: context, lapel: 'Wrong email or password');
              } else {
                customMessage(context: context, lapel: state.errorMessage);
              }
            }
            if (state is SignInSuccess) {
              back;
              // Get.offNamed(Routes.completeProfile,
              //     arguments: CompleteProfileLayout(
              //       currentUser: state.credential,
              //     ));
              userBloc(context).add(GetUserProfileEvent());
            }
          },
          child: child ?? SizedBox.shrink(),
        ),
        BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is GetUserProfileLoading) {
              // showDialog(
              //   context: context,
              //   builder: (context) => Center(
              //     child: CircularProgressIndicator(
              //       color: MyColours.onTerniary,
              //     ),
              //   ),
              // );
            }
            if (state is GetUserProfileErr) {
              // back;
              // if (state.errorMessage ==
              //     'The supplied auth credential is incorrect, malformed or has expired.') {
              //   customMessage(
              //       context: context, lapel: 'Wrong email or password');
              // } else {
              customMessage(context: context, lapel: state.errorMessage);
              // }
            }
            if (state is GetUserProfileSuccess) {
              if (state.user.isSaved == false) {
                Get.offNamed(Routes.completeProfile,
                    arguments: CompleteProfileLayout(
                      currentUser: state.user,
                    ));
                log('false');
              } else {
                log(state.user.toString());
                Get.offNamed(Routes.homeRoute,
                    arguments: TrainneeView(
                      account: state.user,
                    ));
              }

              // back;
              // Get.offNamed(Routes.completeProfile,
              //     arguments: CompleteProfileLayout(
              //       currentUser: state.credential,
              //     ));
            }
          },
          child: child ?? SizedBox.shrink(),
        ),
      ],
      child: child ?? SizedBox.shrink(),
    );
  }
}
