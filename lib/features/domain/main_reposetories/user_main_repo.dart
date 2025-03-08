import 'package:dartz/dartz.dart';
import 'package:mgym/core/failures/remote_failure.dart';
import 'package:mgym/features/data/models/data_model.dart';
import 'package:mgym/features/domain/entities/article_entity.dart';
import 'package:mgym/features/domain/entities/user_entity.dart';
import 'package:mgym/features/domain/entities/video_entity.dart';
import 'package:mgym/features/domain/use_cases/user/upload_user_image_usecase.dart';

abstract class UserBaseRepo {
  Future<Either<Failure, UserEntity>> saveUserProfile(UserEntity account);
  Future<Either<Failure, void>> updateUserProfSave();
  Future<Either<Failure, UserEntity>> getCurrentUserInfo();
  Future<Either<Failure, void>> updateUserProfileMap(Map<String, dynamic> map);
  // Future<Either<Failure, AccountEntity>> getUserProfileL();
  // Future<Either<Failure, DataModel>> uploadUserImage(UploadImageParam param);
  Future<Either<Failure, List<UserEntity>>> getAllUsers();
  Future<Either<Failure, DataModel>> uploadUserImage(UploadImageParam param);
  Future<Either<Failure, List<VideoEntity>>> getVideos();
  Future<Either<Failure, List<ArticleEntity>>> getArticles();
  Future<Either<Failure, void>> updateVidFav(bool val, String name);
  Future<Either<Failure, bool>> updateArticleFav(bool val, String name);
  Future<Either<Failure, List<dynamic>>> getFavorites();
}
