import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mgym/core/locator/setup_locator.dart';
import 'package:mgym/features/presentation/controllers/auth_bloc/auth_bloc.dart';
import 'package:mgym/features/presentation/controllers/user_bloc/bloc/user_bloc.dart';

class AllProviders {
  static get allProviders => [
        BlocProvider(
          create: (_) => locator<AuthBloc>(),
        ),
        BlocProvider(create: (_) => locator<UserBloc>()),
      ];
}
