import 'package:dartz/dartz.dart';
import 'package:mgym/core/failures/remote_failure.dart';
import 'package:mgym/features/data/data_source/remote_data/user_remote_data/user_remote_data.dart';
import 'package:mgym/features/data/models/data_model.dart';
import 'package:mgym/features/domain/entities/article_entity.dart';
import 'package:mgym/features/domain/entities/user_entity.dart';
import 'package:mgym/features/domain/entities/video_entity.dart';
import 'package:mgym/features/domain/main_reposetories/user_main_repo.dart';
import 'package:mgym/features/domain/use_cases/user/upload_user_image_usecase.dart';
 Future<Either<Failure, T>> executeOperation<T>(
      Future<T> Function() operation) async {
    // try {
    final result = await operation(); // Execute the provided operation
    return Right(result); // Wrap the result in a Right instance
    // } on FirebaseException catch (fail) {
    //   return Left(ServerFailure(message: fail.message!));
    // } catch (error) {
    //   // Handle specific errors, map to Failure
    //   return Left(ServerFailure(message: error.toString()));
    // }
  }

class UserRepo extends UserBaseRepo {
  final UserRemoteData _userRemoteData;
  // final FireBaseAuthLocal _authLocalData;

  UserRepo(this._userRemoteData);

 
  @override
  Future<Either<Failure, UserEntity>> saveUserProfile(
      UserEntity account) async {
    return executeOperation(
        () => _userRemoteData.saveUserProfile(account.toModel));
  }

  @override
  Future<Either<Failure, void>> updateUserProfSave() async {
    return executeOperation(
      () => _userRemoteData.updateUserProfileSave(),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUserInfo() async {
    return executeOperation(() => _userRemoteData.getCurrnetUserInfo());
  }

  @override
  Future<Either<Failure, UserEntity>> updateUserProfileMap(Map<String, dynamic> map) {
    return executeOperation(() => _userRemoteData.updateUserProfileMap(map));
  }

  // @override
  // Future<Either<Failure, DataModel>> uploadUserImage(UploadImageParam param) {
  //   return executeOperation(() => _userRemoteData.uploadUserImage(param));
  // }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsers() async {
    return executeOperation(
      () => _userRemoteData.getAllUsers(),
    );
  }

  @override
  Future<Either<Failure, DataModel>> uploadUserImage(UploadImageParam param) {
    return executeOperation(() => _userRemoteData.uploadUserImage(param));
  }

  @override
  Future<Either<Failure, List<ArticleEntity>>> getArticles() {
    return executeOperation(() => _userRemoteData.getArticles());
  }

  @override
  Future<Either<Failure, List<VideoEntity>>> getVideos() {
    return executeOperation(() => _userRemoteData.getVideos());
  }

  @override
  Future<Either<Failure, bool>> updateArticleFav(bool val, String name) {
    return executeOperation(() => _userRemoteData.updateArticleFav(val, name));
  }

  @override
  Future<Either<Failure, void>> updateVidFav(bool val, String name) {
    return executeOperation(() => _userRemoteData.updateVidFav(val, name));
  }

  @override
  Future<Either<Failure, List>> getFavorites() {
    return executeOperation(() => _userRemoteData.getFavorites());
  }
  // @override
  // Stream<bool> getUserStatus(String uid) {
  //   return _userRemoteData.getUserStatus(uid);
  // }

  // @override
  // Stream<int?> getUserLasSeen(String uid) {
  //   return _userRemoteData.getUserLasSeen(uid);
  // }
}
