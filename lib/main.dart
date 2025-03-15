import 'dart:developer';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mgym/all_providers.dart';
import 'package:mgym/core/locator/setup_locator.dart';
import 'package:mgym/core/router/app_router.dart';
import 'package:mgym/core/router/routes.dart';
import 'package:mgym/core/size_config/size_config.dart';
import 'package:mgym/features/data/data_source/remote_data/user_remote_data/user_remote_data.dart';
import 'package:mgym/init_main.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  await initMain();

  runApp(DevicePreview(enabled: true, builder: (context) => const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    requestPermissions();
    locator<UserRemoteData>().getUserMealPlansAccToGoal();
  }

  void requestPermissions() async {
    final PermissionStatus storagePermission =
        await Permission.storage.request();
    final PermissionStatus cameraPermission = await Permission.camera.request();

    if (storagePermission.isGranted) {
      log("Storage permission granted");
    } else if (storagePermission.isDenied) {
      log("Storage permission denied. Requesting again...");
    } else if (storagePermission.isPermanentlyDenied) {
      log("Storage permission permanently denied. Open settings.");
      await openAppSettings();
    }

    if (cameraPermission.isGranted) {
      log("Camera permission granted");
    }
  }

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
