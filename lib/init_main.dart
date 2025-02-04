import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mgym/firebase_options.dart';

void initMain()async{
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
}