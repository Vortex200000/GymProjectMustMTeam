import 'package:mgym/features/domain/entities/article_entity.dart';

class ArticleModel extends ArticleEntity {
  const ArticleModel(
      {required super.articelTitle,
      required super.article,
      required super.articleCoverPhoto,
      required super.isFav,
      required super.id});

  Map<String, dynamic> toMap() {
    return {
      ArticleKeys.articleTitle: articelTitle,
      ArticleKeys.article: article,
      ArticleKeys.articleCoverPhoto: articleCoverPhoto,
      ArticleKeys.isFav: isFav,
    };
  }

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
      articelTitle: map[ArticleKeys.articleTitle],
      article: map[ArticleKeys.article],
      articleCoverPhoto: map[ArticleKeys.articleCoverPhoto],
      isFav: map[ArticleKeys.isFav] ?? false,
      id: map[ArticleKeys.id],
    );
  }
}

class ArticleKeys {
  static const String articleTitle = 'title';
  static const String article = 'article';
  static const String articleCoverPhoto = 'coverPhoto';
  static const String isFav = 'isFav';
  static const String id = 'id';
}
