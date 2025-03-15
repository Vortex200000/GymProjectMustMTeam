part of 'combonents_bloc.dart';

sealed class CombonentsState extends Equatable {
  const CombonentsState();

  @override
  List<Object> get props => [];
}

final class CombonentsInitial extends CombonentsState {}

class UpdateArticleFavLoading extends CombonentsState {}

class UpdateArticleFavSuccess extends CombonentsState {
  final bool favSt;
  const UpdateArticleFavSuccess({required this.favSt});
}

class UpdateArticleFavFailure extends CombonentsState {
  final String errorMessage;
  const UpdateArticleFavFailure({required this.errorMessage});
}

class GetAllArticlesLoading extends CombonentsState {}

class GetAllArticlesLoaded extends CombonentsState {
  final List<ArticleEntity> articles;
  const GetAllArticlesLoaded({required this.articles});
}

class GetAllArticlesFailure extends CombonentsState {
  final String errorMessage;
  const GetAllArticlesFailure({required this.errorMessage});
}

class GetAllFavoritesLoading extends CombonentsState {}

class GetAllFavoritesLoaded extends CombonentsState {
  final List<dynamic> favorites;
  const GetAllFavoritesLoaded({required this.favorites});
}

class GetAllFavoritesFailure extends CombonentsState {
  final String errorMessage;
  const GetAllFavoritesFailure({required this.errorMessage});
}
