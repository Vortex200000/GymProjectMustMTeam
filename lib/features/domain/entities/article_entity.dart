import 'package:equatable/equatable.dart';
import 'package:mgym/features/data/models/article_model.dart';

class ArticleEntity extends Equatable {
  final String articelTitle;
  final String id;

  final String article;
  final String articleCoverPhoto;
  final bool isFav;
  const ArticleEntity(
      {required this.articelTitle,
      required this.article,
      required this.articleCoverPhoto,
      required this.isFav,
      required this.id});

  ArticleEntity copyWith(
    String? articelTitile,
    String? article,
    String? articleCoverPhoto,
    bool? isFav,
    String? id,
  ) {
    return ArticleEntity(
        articelTitle: articelTitile ?? this.articelTitle,
        article: article ?? this.article,
        articleCoverPhoto: articleCoverPhoto ?? this.articleCoverPhoto,
        isFav: isFav ?? this.isFav,
        id: id ?? this.id);
  }

  ArticleModel get toModel => ArticleModel(
        id: id,
        articelTitle: articelTitle,
        article: article,
        articleCoverPhoto: articleCoverPhoto,
        isFav: isFav,
      );
  @override
  List<Object?> get props => [
        articelTitle,
        article,
        articleCoverPhoto,
      ];
}
