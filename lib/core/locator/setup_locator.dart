// import 'package:app/features/data/source/remote_data/calls_remote_data/calls_remote_data.dart';
// import 'package:app/features/domain/base_reposatories/calls/calls_base_rebo.dart';
// import 'package:app/features/domain/base_reposatories/calls/wep_rtc_rebo.dart';

// import 'package:app/features/domain/usecases/calls/calls_use_case.dart';
// import 'package:app/features/presentaion/views/controllers/blocs/calls_bloc/calls_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get_it/get_it.dart';
import 'package:mgym/core/services/api_service.dart';
import 'package:mgym/core/services/firebase_services.dart';
import 'package:mgym/core/services/nuteration_service.dart';
import 'package:mgym/features/data/data_source/remote_data/auth_remote_data/auth_remote_data.dart';
import 'package:mgym/features/data/data_source/remote_data/user_remote_data/user_remote_data.dart';
import 'package:mgym/features/data/reposetories/auth_rebo.dart';
import 'package:mgym/features/data/reposetories/nutriation_repo.dart';
import 'package:mgym/features/data/reposetories/user_rebo.dart';
import 'package:mgym/features/domain/main_reposetories/auth_main_repo.dart';
import 'package:mgym/features/domain/main_reposetories/nutration_main_repo.dart';
import 'package:mgym/features/domain/main_reposetories/user_main_repo.dart';
import 'package:mgym/features/domain/use_cases/auth/is_user_loged_in_use_case.dart';
import 'package:mgym/features/domain/use_cases/auth/log_email_password.dart';
import 'package:mgym/features/domain/use_cases/auth/sign_out_use_case.dart';
import 'package:mgym/features/domain/use_cases/auth/sign_up_use_case.dart';
import 'package:mgym/features/domain/use_cases/nutiration/get_user_meal_use_case.dart';
import 'package:mgym/features/domain/use_cases/user/get_all_users_use_case.dart';
import 'package:mgym/features/domain/use_cases/user/get_current_user_info_use_case.dart';
import 'package:mgym/features/domain/use_cases/user/gym_comp_use_cases.dart';
import 'package:mgym/features/domain/use_cases/user/save_profile_use_case.dart';
import 'package:mgym/features/domain/use_cases/user/update_profile_map_use_case.dart';
import 'package:mgym/features/domain/use_cases/user/update_user_saved_use_case.dart';
import 'package:mgym/features/domain/use_cases/user/upload_user_image_usecase.dart';
import 'package:mgym/features/presentation/controllers/auth_bloc/auth_bloc.dart';
import 'package:mgym/features/presentation/controllers/combonents_bloc/combonents_bloc.dart';
import 'package:mgym/features/presentation/controllers/nutration_bloc/nutration_bloc.dart';
import 'package:mgym/features/presentation/controllers/user_bloc/bloc/user_bloc.dart';

GetIt locator = GetIt.instance;

Future<void> setUp() async {
  final GetIt sl = locator;

  //bloc
  sl.registerFactory(() => AuthBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory(
    () => UserBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()),
  );
  sl.registerFactory(
    () => CombonentsBloc(sl(), sl(), sl()),
  );
  sl.registerFactory(
    () => NutrationBloc(
      sl(),
    ),
  );
  //usecases

  sl.registerLazySingleton(
    () => GetAllArticelsUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => GetFavUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => GetAllVideosUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => UpdateArticleFavUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => UpdateVidFavUseCase(sl()),
  );

  sl.registerLazySingleton(
    () => LoginEmailAndPasswordUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => GetAllUsersUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => CheckIfUserLoggedInUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => SignOutUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => UpdateUserProfSavedUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => UploadUserImageUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => UpdateProfileMapUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => GetUserMealsGoalUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => GetCurrentUserUseCase(sl()),
  );
  sl.registerLazySingleton(() => SaveUserProfileUseCase(sl()));

  sl.registerLazySingleton(
    () => SignUpEmailAndPasswordUseCase(sl()),
  );
//rebo
  sl.registerLazySingleton<AuthMainRepo>(
    () => AuthRebo(
      sl(),
    ),
  );

  sl.registerLazySingleton<UserBaseRepo>(
    () => UserRepo(
      sl(),
    ),
  );

  sl.registerLazySingleton<NutrationMainRepo>(
    () => NutriationRepo(
      sl(),
    ),
  );
  //external services
  sl.registerLazySingleton<AuthRemoteData>(() => AuthFireBase(
        sl(),
      ));
  sl.registerSingleton<DioServcies>(DioServcies());
  sl.registerSingleton<NutirationService>(NutirationService());

  sl.registerLazySingleton<UserRemoteData>(
      () => UserFireBase(sl(), sl(), sl(), sl()));
  sl.registerSingleton<FireBaseService>(FireBaseService());
  sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  sl.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
}
