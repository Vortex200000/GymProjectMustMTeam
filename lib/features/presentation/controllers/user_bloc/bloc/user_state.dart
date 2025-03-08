part of 'user_bloc.dart';

sealed class UserState {}

final class UserInitial extends UserState {}

class SaveUserProfileErr extends UserState {
  final String errorMessage;
  SaveUserProfileErr({required this.errorMessage});
}

class SaveUserProfileLoading extends UserState {}

class SaveUserProfileSuccess extends UserState {
  final UserEntity entity;
  SaveUserProfileSuccess({required this.entity});
}

class UpdateUserProfileSaveLoading extends UserState {}

class UpdateUserProfileSaveErr extends UserState {
  final String errorMessage;
  UpdateUserProfileSaveErr({required this.errorMessage});
}

class UpdateUserProfileSaveSuccess extends UserState {}

class GetUserProfileLoading extends UserState {}

class GetUserProfileSuccess extends UserState {
  final UserEntity user;
  GetUserProfileSuccess({required this.user});
}

class GetUserProfileErr extends UserState {
  final String errorMessage;
  GetUserProfileErr({required this.errorMessage});
}

class UploadUserImageLoading extends UserState {}

class UploadUserImageSuccess extends UserState {
  final DataModel imageUrl;
  UploadUserImageSuccess({required this.imageUrl});
}

class UploadUserImageErr extends UserState {
  final String errorMessage;
  UploadUserImageErr({required this.errorMessage});
}

class UpdateUserProfileMapLoading extends UserState {}

class UpdateUserProfileMapSuccess extends UserState {}

class UpdateUserProfileMapErr extends UserState {
  final String errorMessage;
  UpdateUserProfileMapErr({required this.errorMessage});
}

class GetAllUsersLoaading extends UserState {}

class GetAllUsersSuccess extends UserState {
  final List<UserEntity> users;
  GetAllUsersSuccess({required this.users});
}

class GetAllUsersErr extends UserState {
  final String errorMessage;
  GetAllUsersErr({required this.errorMessage});
}

class GetAllVideosLoading extends UserState {}

class GetAllVideosLoaded extends UserState {
  final List<VideoEntity> videos;
  GetAllVideosLoaded({required this.videos});
}

class GetAllVideosFailure extends UserState {
  final String errorMessage;
  GetAllVideosFailure({required this.errorMessage});
}

// class GetAllArticlesLoading extends UserState {}

// class GetAllArticlesLoaded extends UserState {
//   final List<ArticleEntity> articles;
//   GetAllArticlesLoaded({required this.articles});
// }

// class GetAllArticlesFailure extends UserState {
//   final String errorMessage;
//   GetAllArticlesFailure({required this.errorMessage});
// }

class UpdateVideoFavLoading extends UserState {}

class UpdateVideoFavSuccess extends UserState {}

class UpdateVideoFavFailure extends UserState {
  final String errorMessage;
  UpdateVideoFavFailure({required this.errorMessage});
}

// class UpdateArticleFavLoading extends UserState {}

// class UpdateArticleFavSuccess extends UserState {}

// class UpdateArticleFavFailure extends UserState {
//   final String errorMessage;
//   UpdateArticleFavFailure({required this.errorMessage});
// }
