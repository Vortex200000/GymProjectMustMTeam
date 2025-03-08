part of 'combonents_bloc.dart';

sealed class CombonentsEvent extends Equatable {
  const CombonentsEvent();

  @override
  List<Object> get props => [];
}

class GetAllArticlesEvent extends CombonentsEvent {}

class UpdateArticleFavEvent extends CombonentsEvent {
  final String name;
  final bool isFavorite;
  const UpdateArticleFavEvent(this.name, this.isFavorite);
}

class GetAllFavoritesEvent extends CombonentsEvent {}
