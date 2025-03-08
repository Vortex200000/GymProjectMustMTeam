import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mgym/core/failures/remote_failure.dart';
import 'package:mgym/core/usecase/base_use_case.dart';
import 'package:mgym/features/data/models/data_model.dart';
import 'package:mgym/features/domain/main_reposetories/user_main_repo.dart';


class UploadUserImageUseCase extends BaseUseCase<DataModel, UploadImageParam> {
  final UserBaseRepo _repo;
  UploadUserImageUseCase(this._repo);
  @override
  Future<Either<Failure, DataModel>> call(UploadImageParam param) async {
    log('use case ${param.file.path}');
    return await _repo.uploadUserImage(param);
  }
}

class UploadImageParam extends Equatable {
  final String fileType;
  final File file;
  const UploadImageParam(this.fileType, this.file);
  @override
  List<Object?> get props => [];
}
