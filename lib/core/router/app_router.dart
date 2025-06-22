import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mgym/core/router/routes.dart';
import 'package:mgym/features/presentation/view/community/community_layout.dart';
import 'package:mgym/features/presentation/view/complete_profile/complete_profile_layout.dart';
import 'package:mgym/features/presentation/view/complete_profile/widget/steper/steps.dart';
import 'package:mgym/features/presentation/view/login/login_layout.dart';
import 'package:mgym/features/presentation/view/meal_recipee/meal_recipee_layout.dart';
import 'package:mgym/features/presentation/view/nutration/nutration_layout.dart';
import 'package:mgym/features/presentation/view/on_boarding/on_boarding_layout.dart';
import 'package:mgym/features/presentation/view/progress_tracking/progress_tracking_layout.dart';
import 'package:mgym/features/presentation/view/sign_up/sign_up_layout.dart';
import 'package:mgym/features/presentation/view/splash_screen/splash.dart';
import 'package:mgym/features/presentation/view/trainee_view/trainee_view_layout.dart';
import 'package:mgym/features/presentation/view/training/training_layout.dart';
import 'package:mgym/features/presentation/view/user_profile/user_profile_layout.dart';

class AppRouter {
  static List<GetPage<dynamic>>? getPages = [
    getPage(Routes.loginRoute, page: () => const LoginLayout()),
    getPage(Routes.signUpRoute, page: () => const SignUpLayout()),
    getPage(Routes.splashScreen, page: () => const SplashScreen()),
    getPage(Routes.onBoarding, page: () => const OnBoardingLayout()),
    getPage(Routes.splash2, page: () => const Splash2()),
    getPage(Routes.completeProfile, page: () {
      CompleteProfileLayout arg = Get.arguments;
      return CompleteProfileLayout(
        currentUser: arg.currentUser,
      );
    }),
    getPage(Routes.training, page: () => const TrainingLayout()),

    getPage(Routes.steps, page: () {
      StebsLayout arg = Get.arguments;
      return StebsLayout(
        userCredential: arg.userCredential,
      );
    }),
    getPage(Routes.nutration, page: () {
      NutrationTap arg = Get.arguments;
      return NutrationTap(
        user: arg.user,
      );
    }),
    getPage(Routes.recipes, page: () {
      MealRecipeLayout arg = Get.arguments;
      return MealRecipeLayout(
        user: arg.user,
        ingreduants: arg.ingreduants,
      );
    }),

    getPage(Routes.userProfile, page: () {
      UserProfileLayout arg = Get.arguments;
      return UserProfileLayout(
        user: arg.user,
      );
    }),
    getPage(Routes.homeRoute, page: () {
      TrainneeView arg = Get.arguments;
      return TrainneeView(
        account: arg.account,
      );
    }),
    getPage(Routes.homeRoute, page: () {
      TrainneeView arg = Get.arguments;
      return TrainneeView(
        account: arg.account,
      );
    }),
    getPage(Routes.progress, page: () {
      BorgressTrackingLayout arg = Get.arguments;
      return BorgressTrackingLayout(
        account: arg.account,
      );
    }),
    getPage(Routes.community, page: () {
      CommunityLayout arg = Get.arguments;
      return CommunityLayout(
        user: arg.user,
      );
    }),

    // getPage(Routes.signUpRoute, page: () => const SignUpLayout()),
    // getPage(Routes.homeRoute, page: () {
    //   HomeLayout arg = Get.arguments;
    //   return HomeLayout(
    //     user: arg.user,
    //   );
    // }),
    // //CallScreenVideoLayout
    // getPage(Routes.callScrenn, page: () {
    //   CallScreenVideoLayout arg = Get.arguments;
    //   return CallScreenVideoLayout(
    //     args: arg.args,
    //   );
    // }),

    // getPage(Routes.forgotPassword, page: () => const ResetePasswordLayout()),
    // getPage(Routes.customLoadin, page: () => const CustomLoading()),
    // getPage(Routes.completeProfile, page: () {
    //   CompleteProfileLayout arg = Get.arguments;
    //   return CompleteProfileLayout(isLoading: arg.isLoading);
    // }),
    // getPage(Routes.account, page: () => const AccountLayout()),
    // getPage(Routes.notifications, page: () => const NotificationsLayout()),
    // getPage(
    //   Routes.settingsPage,
    //   page: () => const SettingsLayout(),
    // ),
    // getPage(
    //   Routes.splashScreen,
    //   page: () => const SplashScreen(),
    // )
  ];
}

GetPage<dynamic> getPage(
  String name, {
  required Widget Function() page,
  Transition transition = Transition.cupertino,
  Curve curve = Curves.easeInOut,
  double delayed = .5,
}) {
  return GetPage(
    name: name,
    page: page,
    curve: curve,
    transition: transition,
    participatesInRootNavigator: false,
    fullscreenDialog: true,
    transitionDuration: Duration(milliseconds: (delayed * 1000).toInt()),
  );
}

GetPage<dynamic> trantion(
  String name, {
  required Widget Function() page,
  Transition transition = Transition.circularReveal,
  Curve curve = Curves.slowMiddle,
  double delayed = .7,
}) {
  return GetPage(
    name: name,
    page: page,
    curve: curve,
    transition: transition,
    participatesInRootNavigator: false,
    fullscreenDialog: true,
    transitionDuration: Duration(milliseconds: (delayed * 1000).toInt()),
  );
}
