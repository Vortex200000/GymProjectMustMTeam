import 'package:dartz/dartz.dart';
import 'package:mgym/core/failures/remote_failure.dart';
import 'package:mgym/core/usecase/base_use_case.dart';
import 'package:mgym/features/domain/entities/article_entity.dart';
import 'package:mgym/features/domain/entities/video_entity.dart';
import 'package:mgym/features/domain/main_reposetories/user_main_repo.dart';

class GetAllArticelsUseCase
    extends BaseUseCase<List<ArticleEntity>, NoParameters> {
  GetAllArticelsUseCase(this._repo);
  final UserBaseRepo _repo;
  @override
  Future<Either<Failure, List<ArticleEntity>>> call(NoParameters param) {
    return _repo.getArticles();
  }
}

class GetAllVideosUseCase extends BaseUseCase<List<VideoEntity>, NoParameters> {
  GetAllVideosUseCase(this._repo);
  final UserBaseRepo _repo;
  @override
  Future<Either<Failure, List<VideoEntity>>> call(NoParameters param) {
    return _repo.getVideos();
  }
}

class UpdateArticleFavUseCase {
  UpdateArticleFavUseCase(this._repo);
  final UserBaseRepo _repo;

  Future<Either<Failure, bool>> call(String param, bool val) {
    return _repo.updateArticleFav(val, param);
  }
}

class UpdateVidFavUseCase {
  UpdateVidFavUseCase(this._repo);
  final UserBaseRepo _repo;
  Future<Either<Failure, void>> call(String param, bool val) {
    return _repo.updateVidFav(val, param);
  }
}

class GetFavUseCase {
  final UserBaseRepo _repo;
  GetFavUseCase(this._repo);
  Future<Either<Failure, List<dynamic>>> call() {
    return _repo.getFavorites();
  }
}
