import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mgym/core/router/controller.dart';
import 'package:mgym/core/router/routes.dart';
import 'package:mgym/features/presentation/controllers/user_bloc/bloc/user_bloc.dart';
import 'package:mgym/features/presentation/shared/custom_message/custom_message.dart';
import 'package:mgym/features/presentation/view/complete_profile/controller/controller.dart';
import 'package:mgym/features/presentation/view/trainee_view/trainee_view_layout.dart';

class ProfileBuListner extends StatelessWidget {
  const ProfileBuListner({
    super.key,
    this.child,
    // required this.name,
    // required this.nickName,
    required this.stepsController,
  });
  final Widget? child;
  // final String name;
  // final String nickName;
  final StepsController stepsController;
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(listeners: [
      BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UploadUserImageLoading) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => Center(
                child: const CircularProgressIndicator(),
              ),
            );
            // Routes.customLoadin.toPage();
          }
          if (state is UploadUserImageErr) {
            back;
            userBloc(context).add(GetUserProfileEvent());
            customMessage(
                context: context, lapel: state.errorMessage, title: '');
          }
          if (state is UploadUserImageSuccess) {
            back;
            // log('${state.imageUrl.fileUrl}');
            // userBloc(context).accountEntity = userBloc(context)
            //     .accountEntity
            //     .copyWith(isSaved: true, profileImage: state.imageUrl.fileUrl);

            // userBloc(context)
            //     .add(SaveUserProfileEvent(userBloc(context).accountEntity));
            stepsController.userEntity = stepsController.userEntity.cobyWith(
                // fullName: name,
                // nickName: nickName,
                isSaved: true,
                photoUrl: state.imageUrl.fileUrl);

            userBloc(context)
                .add(SaveUserProfileEvent(stepsController.userEntity));
          }
        },
        child: child ?? const SizedBox.shrink(),
      ),
      BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is GetUserProfileLoading) {
            back;
          }
          if (state is SaveUserProfileErr) {
            back;
            userBloc(context).add(GetUserProfileEvent());
            customMessage(
                context: context, lapel: state.errorMessage, title: '');
          }
          if (state is SaveUserProfileSuccess) {
            back;

            // userBloc(context).accountEntity =
            //     userBloc(context).accountEntity.copyWith(
            //           isSaved: true,
            //         );
            // userBloc(context)
            //     .add(SaveUserProfileEvent(userBloc(context).accountEntity));
            Get.offNamed(Routes.homeRoute,
                arguments: TrainneeView(
                  account: state.entity,
                ));
          }
        },
        child: child ?? const SizedBox.shrink(),
      ),
    ], child: child ?? const SizedBox.shrink());
  }
}
