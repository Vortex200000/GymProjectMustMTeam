import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mgym/core/constants/colors.dart';
import 'package:mgym/core/size_config/size_config.dart';
import 'package:mgym/features/presentation/shared/custom_cached_image/custom_image_widget.dart';
// import 'package:mgym/features/presentation/shared/custom_button/custom_button.dart';
import 'package:mgym/features/presentation/shared/custom_circle_button/custom_circle_button.dart';
import 'package:mgym/features/presentation/view/complete_profile/controller/controller.dart';
// import 'package:mgym/features/presentation/shared/custom_cached_image/custom_image_widget.dart';

class ImapgePickerWid extends StatefulWidget {
  const ImapgePickerWid(
      {super.key,
      this.imageUrl = '',
      this.width,
      this.height,
      this.fit = BoxFit.contain,
      this.isShadow = true,
      this.buttonHight,
      this.bloc,
      this.onImagePicked,
      this.stepsController});
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final bool isShadow;
  final bool? buttonHight;
  final Bloc? bloc;
  final StepsController? stepsController;

  final ValueChanged<String>? onImagePicked;

  @override
  State<ImapgePickerWid> createState() => _ImapgePickerWidState();
}

class _ImapgePickerWidState extends State<ImapgePickerWid> {
  late String iimageUrl;

  @override
  void initState() {
    super.initState();

    iimageUrl = widget.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomImageWidget(
          url: iimageUrl,
          height: 100.rH,
          width: 100.rW,
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: 0,
          right: -5,
          child: CustomCircleButton(
            listOfWidget: [Icon(Icons.edit)],
            width: 30.rW,
            height: 30.rH,
            isSadow: false,
            backgroundColor: MyColours.onTerniary,
            onTap: () {
              _pickAndUploadImage().then((value) => {
                    if (value != null) log(value.path),
                    iimageUrl = value!.path,
                    // userBloc(context).accountEntity = userBloc(context)
                    //     .accountEntity
                    //     .copyWith(profileImage: value.path),
                    if (widget.stepsController != null)
                      {
                        widget.stepsController!.userEntity = widget
                            .stepsController!.userEntity
                            .cobyWith(photoUrl: value.path),
                        // widget.onImagePicked!(
                        //     widget.stepsController.userEntity.photoUrl),

                        log(' image path ${widget.stepsController!.userEntity.photoUrl}'),
                        setState(() {})
                      }
                  });
            },
          ),
        ),
      ],
    );
  }

  // File? _imageFile;

  // Updated to use file_picker
  Future<File?> _pickAndUploadImage() async {
    try {
      // Open the file picker and allow the user to pick an image
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType
            .image, // You can change this to FileType.any for all file types
      );

      if (result != null) {
        // If a file is selected, return the file
        final file = File(result.files.single.path!);
        return file;
      } else {
        log('User canceled the file picker');
      }
    } catch (e) {
      log('Error picking file: $e');
    }

    return null;
  }
}

class ProfileImageHandler {
  // Removed ImagePicker import as we're using file_picker now
  // final ImagePicker _picker = ImagePicker();

  // Pick image from the device
  Future<File?> pickImage() async {
    try {
      // Open the file picker for image files
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null) {
        return File(result.files.single.path!);
      } else {
        log('User canceled');
      }
    } catch (e) {
      log('Error picking image: $e');
    }
    return null;
  }
}
