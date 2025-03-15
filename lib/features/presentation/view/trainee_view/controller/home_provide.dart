import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mgym/features/presentation/controllers/user_bloc/bloc/user_bloc.dart';

class AddVidFavListener extends StatelessWidget {
  const AddVidFavListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UpdateVideoFavSuccess) {
          userBloc(context).add(GetAllVideosEvent());
        }
        if (state is UpdateUserProfileMapSuccess) {
          userBloc(context).add(GetUserProfileEvent());
          userBloc(context).add(GetAllVideosEvent());
        }
      },
      child: SizedBox.shrink(),
    );
  }
}
