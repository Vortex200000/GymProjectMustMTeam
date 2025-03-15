import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mgym/core/usecase/base_use_case.dart';
import 'package:mgym/features/domain/entities/article_entity.dart';
import 'package:mgym/features/domain/use_cases/user/gym_comp_use_cases.dart';

part 'combonents_event.dart';
part 'combonents_state.dart';

class CombonentsBloc extends Bloc<CombonentsEvent, CombonentsState> {
  static CombonentsBloc get(context) => BlocProvider.of(context);

  final UpdateArticleFavUseCase _updateArticleFavUseCase;
  final GetAllArticelsUseCase _getAllArticelsUseCase;
  final GetFavUseCase _getFavUseCase;

  CombonentsBloc(this._updateArticleFavUseCase, this._getAllArticelsUseCase,
      this._getFavUseCase)
      : super(CombonentsInitial()) {
    on<GetAllArticlesEvent>(_getAllArticles);
    on<UpdateArticleFavEvent>(_updateArticleFav);
    on<GetAllFavoritesEvent>(_getAllFavorites);
  }

  late List<ArticleEntity> articles;
  Future<void> _getAllArticles(
      GetAllArticlesEvent event, Emitter<CombonentsState> emit) async {
    emit(GetAllArticlesLoading());
    final result = await _getAllArticelsUseCase.call(const NoParameters());
    result.fold(
      (fail) {
        emit(GetAllArticlesFailure(errorMessage: fail.message));
      },
      (success) {
        articles = success;
        emit(GetAllArticlesLoaded(articles: success));
      },
    );
  }

  Future<void> _getAllFavorites(
      GetAllFavoritesEvent event, Emitter<CombonentsState> emit) async {
    emit(GetAllFavoritesLoading());
    final result = await _getFavUseCase.call();
    result.fold(
      (fail) {
        emit(GetAllFavoritesFailure(errorMessage: fail.message));
      },
      (success) {
        emit(GetAllFavoritesLoaded(favorites: success));
      },
    );
  }

  Future<void> _updateArticleFav(
      UpdateArticleFavEvent event, Emitter<CombonentsState> emit) async {
    emit(UpdateArticleFavLoading());
    final result =
        await _updateArticleFavUseCase.call(event.name, event.isFavorite);
    result.fold(
      (fail) {
        emit(UpdateArticleFavFailure(errorMessage: fail.message));
      },
      (success) {
        emit(UpdateArticleFavSuccess(favSt: success));
      },
    );
  }
}

CombonentsBloc combBloc(BuildContext context) => CombonentsBloc.get(context);
