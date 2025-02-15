import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mgym/core/constants/colors.dart';
import 'package:mgym/core/router/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startApp();
  }

  void _startApp() async {
    await Future.delayed(Duration(seconds: 3));
    Get.offNamed(Routes.splash2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child:
            Scaffold(backgroundColor: MyColours.onPrimary, body: Container()),
      ),
    );
  }
}
