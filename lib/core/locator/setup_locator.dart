// import 'package:app/features/data/source/remote_data/calls_remote_data/calls_remote_data.dart';
// import 'package:app/features/domain/base_reposatories/calls/calls_base_rebo.dart';
// import 'package:app/features/domain/base_reposatories/calls/wep_rtc_rebo.dart';

// import 'package:app/features/domain/usecases/calls/calls_use_case.dart';
// import 'package:app/features/presentaion/views/controllers/blocs/calls_bloc/calls_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get_it/get_it.dart';
import 'package:mgym/core/services/firebase_services.dart';
import 'package:mgym/features/data/data_source/remote_data/auth_remote_data/auth_remote_data.dart';
import 'package:mgym/features/data/reposetories/auth_rebo.dart';
import 'package:mgym/features/domain/main_reposetories/auth_main_repo.dart';
import 'package:mgym/features/domain/use_cases/auth/log_email_password.dart';
import 'package:mgym/features/domain/use_cases/auth/sign_up_use_case.dart';
import 'package:mgym/features/presentation/controllers/auth_bloc/auth_bloc.dart';

GetIt locator = GetIt.instance;

Future<void> setUp() async {
  final GetIt sl = locator;

  //bloc
  sl.registerFactory(() => AuthBloc(
        sl(),
        sl(),
      ));

  //usecases
  sl.registerLazySingleton(
    () => LoginEmailAndPasswordUseCase(sl()),
  );

  sl.registerLazySingleton(
    () => SignUpEmailAndPasswordUseCase(sl()),
  );
//rebo
  sl.registerLazySingleton<AuthMainRepo>(
    () => AuthRebo(
      sl(),
    ),
  );
  //external services
  sl.registerLazySingleton<AuthRemoteData>(() => AuthFireBase(
        sl(),
      ));
  sl.registerSingleton<FireBaseService>(FireBaseService());
  sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  sl.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
}
