import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mgym/core/constants/colors.dart';
import 'package:mgym/core/router/controller.dart';
import 'package:mgym/features/domain/entities/user_entity.dart';
import 'package:mgym/features/presentation/controllers/auth_bloc/auth_bloc.dart';
import 'package:mgym/features/presentation/controllers/user_bloc/bloc/user_bloc.dart';
import 'package:mgym/features/presentation/shared/custom_message/custom_message.dart';

class SignUpProvider extends StatelessWidget {
  const SignUpProvider({super.key, required this.builder});
  final Widget Function(AuthBloc, AuthState) builder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return builder(authBloc(context), state);
      },
    );
  }
}

class SignUpListner extends StatelessWidget {
  const SignUpListner({super.key, this.child, required this.phoneNum});
  final Widget? child;
  final String phoneNum;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SignUpLoading) {
          showDialog(
            context: context,
            builder: (context) => Center(
              child: CircularProgressIndicator(
                color: MyColours.onTerniary,
              ),
            ),
          );
        }
        if (state is SignUpFailure) {
          back;

          customMessage(context: context, lapel: state.errorMessage);
        }
        if (state is SignUpSuccess) {
          back;
          userBloc(context).add(SaveUserProfileEvent(UserEntity(
              age: 0,
              email: state.credential.user!.email ?? '',
              id: state.credential.user!.uid,
              fullName: '',
              gender: '',
              isSaved: false,
              hight: 0,
              nickName: '',
              phoneNum: phoneNum,
              photoUrl: '',
              userType: 'trainee',
              weight: 0,
              goal: '')));
          customMessage(
              context: context,
              lapel: 'Your account has been successfully created',
              title: '');
        }
      },
      child: child ?? SizedBox.shrink(),
    );
  }
}
