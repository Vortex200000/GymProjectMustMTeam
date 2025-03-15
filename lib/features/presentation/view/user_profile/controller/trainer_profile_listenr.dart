import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mgym/core/constants/colors.dart';
import 'package:mgym/core/router/controller.dart';
import 'package:mgym/features/domain/entities/user_entity.dart';
import 'package:mgym/features/presentation/controllers/user_bloc/bloc/user_bloc.dart';

class TraineeProfileListenr extends StatelessWidget {
  const TraineeProfileListenr({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UpdateUserProfileMapErr) {}
        if (state is UpdateUserProfileMapLoading) {
          showDialog(
            context: context,
            builder: (context) => Center(
              child: CircularProgressIndicator(
                color: MyColours.onTerniary,
              ),
            ),
          );
        }
        if (state is UpdateUserProfileMapSuccess) {
          back;
          // userBloc(context).add(GetUserProfileEvent());
        }
      },
      child: SizedBox.shrink(),
    );
  }
}

class TrainerProfileProvider extends StatelessWidget {
  const TrainerProfileProvider(
      {super.key,
      required this.onLoading,
      required this.onError,
      required this.onSuccess,
      required this.onotialW});
  final Widget Function() onLoading;
  final Widget Function() onError;
  final Function(UserEntity) onSuccess;
  final Widget Function() onotialW;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UpdateUserProfileMapLoading) {
          return onLoading();
        }
        if (state is UpdateUserProfileMapSuccess) {
          // back;
          // userBloc(context).add(GetUserProfileEvent());
          userBloc(context).add(GetAllVideosEvent());
          return onSuccess(state.entity) ?? SizedBox.shrink();
        }
        if (state is UpdateUserProfileMapErr) {
          return onError();
        }
        return onotialW();
      },
    );
  }
}
