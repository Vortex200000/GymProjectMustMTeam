part of 'user_bloc.dart';

sealed class UserEvent {}

class SaveUserProfileEvent extends UserEvent {
  final UserEntity entity;
  SaveUserProfileEvent(this.entity);
}

class UpdateUserProfileSaveEvent extends UserEvent {}

class GetUserProfileEvent extends UserEvent {
  final bool isLoading;
  GetUserProfileEvent({this.isLoading = false});
}

class UploadImageEvent extends UserEvent {
  final UploadImageParam param;

  UploadImageEvent(this.param);
}

class UpdateUserProfileMap extends UserEvent {
  final Map<String, dynamic> updates;
  UpdateUserProfileMap(this.updates);
}

class GetAllUsersEvent extends UserEvent {}

// class GetUserStatusEvent extends UserEvent {}
// class GetAllArticlesEvent extends UserEvent {}

class GetAllVideosEvent extends UserEvent {}

// class UpdateArticleFavEvent extends UserEvent {
//   final String name;
//   final bool isFavorite;
//   UpdateArticleFavEvent(this.name, this.isFavorite);
// }

class UpdateVideoFavEvent extends UserEvent {
  final String name;
  final bool isFavorite;
  UpdateVideoFavEvent(this.name, this.isFavorite);
}
