import 'package:flutter/material.dart';
import 'package:mgym/features/data/models/user_model.dart';
import 'package:mgym/features/domain/entities/user_entity.dart';
import 'package:mgym/features/presentation/controllers/user_bloc/bloc/user_bloc.dart';

class TrainerProfileController extends ChangeNotifier {
  late UserEntity _user;
  UserEntity get user => _user;
  void initialtizeTrainerProf(UserEntity user) {
    _user = user;

    emailController.text = user.email;
    nameController.text = user.fullName;
    phoneController.text = user.phoneNum;
    weightController.text = '${user.weight.toString()}';
    hightontroller.text = '${user.hight.toString()}';
    // emailController = TextEditingController(text: user.email);
    // nameController = TextEditingController(text: user.fullName);
    // phoneController = TextEditingController(text: user.phoneNum);
    // weightController =
    //     TextEditingController(text: '${user.weight.toString()} Kg');
    // hightontroller = TextEditingController(text: '${user.hight.toString()} Cm');
  }

  TextEditingController emailController = TextEditingController();
  // TextEditingController(text: widget.user.email);
  TextEditingController nameController = TextEditingController();
  // TextEditingController(text: widget.user.fullName);
  TextEditingController phoneController = TextEditingController();
  // TextEditingController(text: widget.user.phoneNum);
  TextEditingController weightController = TextEditingController();
  // TextEditingController(text: '${widget.user.weight.toString()} Kg');
  TextEditingController hightontroller = TextEditingController();
  // TextEditingController(text: '${widget.user.hight.toString()} Cm');

  void updateUserProfile(BuildContext context) {
    userBloc(context).add(UpdateUserProfileMap({
      UserKeys.fullName: nameController.text,
      UserKeys.email: emailController.text,
      UserKeys.phoneNum: phoneController.text,
      UserKeys.weight: weightController.text.toInt(),
      UserKeys.hight: hightontroller.text.toInt(),
    }));
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    weightController.dispose();
    hightontroller.dispose();
    super.dispose();
  }
}

extension ToInt on String {
  int toInt({int defaultValue = 0}) {
    return int.parse(this);
  }
}
