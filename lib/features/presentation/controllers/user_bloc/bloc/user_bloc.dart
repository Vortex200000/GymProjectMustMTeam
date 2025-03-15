// import 'dart:io';

// import 'package:bloc/bloc.dart';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mgym/core/usecase/base_use_case.dart';
import 'package:mgym/features/data/models/data_model.dart';
import 'package:mgym/features/domain/entities/user_entity.dart';
import 'package:mgym/features/domain/entities/video_entity.dart';
import 'package:mgym/features/domain/use_cases/user/get_all_users_use_case.dart';
import 'package:mgym/features/domain/use_cases/user/get_current_user_info_use_case.dart';
import 'package:mgym/features/domain/use_cases/user/gym_comp_use_cases.dart';
import 'package:mgym/features/domain/use_cases/user/save_profile_use_case.dart';
import 'package:mgym/features/domain/use_cases/user/update_profile_map_use_case.dart';
import 'package:mgym/features/domain/use_cases/user/update_user_saved_use_case.dart';
import 'package:mgym/features/domain/use_cases/user/upload_user_image_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  static UserBloc get(context) => BlocProvider.of(context);
  final SaveUserProfileUseCase _saveUserProfileUseCase;
  final UpdateUserProfSavedUseCase _updateUserProfSavedUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final UploadUserImageUseCase _uploadImageUseCase;
  final UpdateProfileMapUseCase _updateProfileMapUseCase;
  final GetAllUsersUseCase _getAllUsersUseCase;
  // final GetUserStatusUseCase _getUserStatusUseCase;
  // final GetUserLasSeenUseCase _getUserLasSeenUseCase;
  // final GetAllArticelsUseCase _getAllArticelsUseCase;
  final GetAllVideosUseCase _getAllVideosUseCase;
  // final UpdateArticleFavUseCase _updateArticleFavUseCase;
  final UpdateVidFavUseCase _updateVideoFavUseCase;

  UserBloc(
    this._saveUserProfileUseCase,
    this._updateUserProfSavedUseCase,
    this._getCurrentUserUseCase,
    // this._uploadImageUseCase,
    this._updateProfileMapUseCase,
    this._getAllUsersUseCase,
    this._uploadImageUseCase,
    // this._getAllArticelsUseCase,
    this._getAllVideosUseCase,
    // this._updateArticleFavUseCase,
    this._updateVideoFavUseCase,
    // this._getUserStatusUseCase,
    // this._getUserLasSeenUseCase
  ) : super(UserInitial()) {
    on<SaveUserProfileEvent>(_saveUserProfile);
    on<UpdateUserProfileSaveEvent>(_updateUserSave);
    on<GetUserProfileEvent>(_getUserProfile);
    on<UploadImageEvent>(_uploadImageEvent);
    on<UpdateUserProfileMap>(_updateUserProfileMap);
    on<GetAllUsersEvent>(_getAllUsers);
    on<GetAllVideosEvent>(_getAllVideos);
    // on<GetAllArticlesEvent>(_getAllArticles);
    // on<UpdateArticleFavEvent>(_updateArticleFav);
    on<UpdateVideoFavEvent>(_updateVideoFav);
  }

  late UserEntity accountEntity;
  late String imageUrl;
  late List<UserEntity> accounts;
  // late String username;

  Future<void> _saveUserProfile(
      SaveUserProfileEvent event, Emitter<UserState> emit) async {
    emit(SaveUserProfileLoading());
    final result = await _saveUserProfileUseCase.call(event.entity);
    result.fold(
      (fail) {
        emit(SaveUserProfileErr(errorMessage: fail.message));
      },
      (success) {
        accountEntity = success;
        emit(SaveUserProfileSuccess(entity: success));
      },
    );
  }

  Future<void> _updateUserSave(
      UpdateUserProfileSaveEvent event, Emitter<UserState> emit) async {
    emit(UpdateUserProfileSaveLoading());
    final result = await _updateUserProfSavedUseCase.call(const NoParameters());
    result.fold(
      (fail) {
        emit(UpdateUserProfileSaveErr(errorMessage: fail.message));
      },
      (success) {
        emit(UpdateUserProfileSaveSuccess());
      },
    );
  }

  Future<void> _getUserProfile(
      GetUserProfileEvent event, Emitter<UserState> emit) async {
    emit(GetUserProfileLoading());
    if (event.isLoading) {
      await Future.delayed(const Duration(seconds: 5));
    }
    final result = await _getCurrentUserUseCase.call(const NoParameters());
    result.fold(
      (fail) {
        emit(GetUserProfileErr(errorMessage: fail.message));
      },
      (success) {
        accountEntity = success;
        // imageUrl = success.profileImage;
        // log(accountEntity.account);

        // username = success.userName;
        emit(GetUserProfileSuccess(user: success));
      },
    );
  }

  Future<void> _uploadImageEvent(
      UploadImageEvent event, Emitter<UserState> emit) async {
    emit(UploadUserImageLoading());
    // await Future.delayed(const Duration(seconds: 5));
    final result = await _uploadImageUseCase.call(event.param);
    log(event.param.file.path);
    result.fold(
      (fail) {
        emit(UploadUserImageErr(errorMessage: fail.message));
      },
      (success) {
        imageUrl = success.fileUrl;
        accountEntity = accountEntity.cobyWith(photoUrl: success.fileUrl);

        emit(UploadUserImageSuccess(imageUrl: success));

        log('success');
        // log(success.fileUrl);
      },
    );
  }

  Future<void> _updateUserProfileMap(
      UpdateUserProfileMap event, Emitter<UserState> emit) async {
    emit(UpdateUserProfileMapLoading());
    final result = await _updateProfileMapUseCase.call(event.updates);
    result.fold(
      (fail) {
        emit(UpdateUserProfileMapErr(errorMessage: fail.message));
      },
      (success) {
        accountEntity = success;
        emit(UpdateUserProfileMapSuccess(success));
      },
    );
  }

  // Stream<bool> getUserStatus(String uid) => _getUserStatusUseCase(uid);
  // Stream<int?> getUserLaseSeen(String uid) => _getUserLasSeenUseCase(uid);

  Future<void> _getAllUsers(
      GetAllUsersEvent event, Emitter<UserState> emit) async {
    emit(GetAllUsersLoaading());
    final result = await _getAllUsersUseCase.call(const NoParameters());
    result.fold(
      (fail) {
        emit(GetAllUsersErr(errorMessage: fail.message));
      },
      (success) {
        accounts = success;
        emit(GetAllUsersSuccess(users: success));
      },
    );
  }

  Future<void> _getAllVideos(
      GetAllVideosEvent event, Emitter<UserState> emit) async {
    emit(GetAllVideosLoading());
    final result = await _getAllVideosUseCase.call(const NoParameters());
    result.fold(
      (fail) {
        emit(GetAllVideosFailure(errorMessage: fail.message));
      },
      (success) {
        emit(GetAllVideosLoaded(videos: success));
      },
    );
  }

  // Future<void> _getAllArticles(
  //     GetAllArticlesEvent event, Emitter<UserState> emit) async {
  //   emit(GetAllArticlesLoading());
  //   final result = await _getAllArticelsUseCase.call(const NoParameters());
  //   result.fold(
  //     (fail) {
  //       emit(GetAllArticlesFailure(errorMessage: fail.message));
  //     },
  //     (success) {
  //       emit(GetAllArticlesLoaded(articles: success));
  //     },
  //   );
  // }

  // Future<void> _updateArticleFav(
  //     UpdateArticleFavEvent event, Emitter<UserState> emit) async {
  //   emit(UpdateArticleFavLoading());
  //   final result =
  //       await _updateArticleFavUseCase.call(event.name, event.isFavorite);
  //   result.fold(
  //     (fail) {
  //       emit(UpdateArticleFavFailure(errorMessage: fail.message));
  //     },
  //     (success) {
  //       emit(UpdateArticleFavSuccess());
  //     },
  //   );
  // }

  Future<void> _updateVideoFav(
      UpdateVideoFavEvent event, Emitter<UserState> emit) async {
    emit(UpdateVideoFavLoading());
    final result =
        await _updateVideoFavUseCase.call(event.name, event.isFavorite);
    result.fold(
      (fail) {
        emit(UpdateVideoFavFailure(errorMessage: fail.message));
      },
      (success) {
        emit(UpdateVideoFavSuccess());
      },
    );
  }
}

UserBloc userBloc(BuildContext context) => UserBloc.get(context);
