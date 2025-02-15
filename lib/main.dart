import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mgym/all_providers.dart';
import 'package:mgym/core/router/app_router.dart';
import 'package:mgym/core/router/routes.dart';
import 'package:mgym/core/size_config/size_config.dart';
import 'package:mgym/init_main.dart';

void main() {
  initMain();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return MultiBlocProvider(
      providers: AllProviders.allProviders,
      child: GetMaterialApp(
        getPages: AppRouter.getPages,
        debugShowCheckedModeBanner: false,
        initialRoute:
            // Routes.completeProfile
            Routes.splashScreen,
      ),
    );
  }
}
