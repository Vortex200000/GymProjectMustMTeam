import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mgym/core/locator/setup_locator.dart';
import 'package:mgym/core/observer/bloc_observer.dart';
import 'package:mgym/firebase_options.dart';

void initMain() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setUp();
  // NotificationServices notificationService = NotificationServices();
  // await notificationService.initialize();

  Bloc.observer = MyBlocObserver();
}
