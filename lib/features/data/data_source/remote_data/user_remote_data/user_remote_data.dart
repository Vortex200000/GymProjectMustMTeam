import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mgym/core/services/api_service.dart';
import 'package:mgym/core/services/firebase_services.dart';
import 'package:mgym/features/data/models/article_model.dart';
import 'package:mgym/features/data/models/data_model.dart';
import 'package:mgym/features/data/models/user_model.dart';
import 'package:mgym/features/data/models/video_model.dart';
import 'package:mgym/features/domain/use_cases/user/upload_user_image_usecase.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// import 'package:app/features/data/models/data_model.dart';

abstract class UserRemoteData {
  Future<UserModel> saveUserProfile(UserModel accountModel);
  Future<UserModel> getUserProfileInfo(String id);
  Future<void> updateUserProfileMap(Map<String, dynamic> map);
  Future<UserModel> getCurrnetUserInfo();
  Future<void> updateUserProfileSave();
  // Future<String> uploadUserImage(File imageFile);
  Future<DataModel> uploadUserImage(UploadImageParam param);
  Future<List<UserModel>> getAllUsers();

  Future<List<VideoModel>> getVideos();
  Future<List<ArticleModel>> getArticles();
  Future<void> updateVidFav(bool val, String name);
  Future<bool> updateArticleFav(bool val, String name);
  Future<List<dynamic>> getFavorites();
  // Future<void> updatUserStatus(bool isOnline);
  // Stream<bool> getUserStatus(String uid);
  // Stream<int?> getUserLasSeen(String uid);
}

class UserFireBase extends UserRemoteData {
  // final FirebaseAuth
  UserFireBase(
    this._auth,
    this._fireStoreService,
    this._dioServcies,
    // this._dioServcies,
  );
  final FirebaseAuth _auth;
  // final FirebaseFirestore _fireStore;
  final FireBaseService _fireStoreService;
  final DioServcies _dioServcies;

  // final FirebaseStorage _fireBaseStorage = FirebaseStorage.instance;
  // final DioServcies _dioServcies;

  @override
  Future<UserModel> saveUserProfile(UserModel accountModel) async {
    await _fireStoreService.accountRef
        .doc(accountModel.id)
        .set(accountModel.toMap());

    return accountModel;
  }

  @override
  Future<UserModel> getUserProfileInfo(String id) async {
    final result = await _fireStoreService.accountRef.doc(id).get();

    return UserModel.fromMap(result.data() ?? {});
  }

  // Map<String, dynamic> saveProfMap(String id, bool state) => {
  //   AccountKeys.id : id ,
  //   AccountKeys.isSaved : state
  // };
  @override
  Future<void> updateUserProfileMap(Map<String, dynamic> map) async {
    log('id =============>${_auth.currentUser!.uid}');
    return await _fireStoreService.accountRef
        .doc(_auth.currentUser!.uid)
        .update(map);
  }

  Future<void> updateAnyUserProfileMap(Map<String, dynamic> map) async {
    return await _fireStoreService.accountRef.doc(map[UserKeys.id]).update(map);
  }

  @override
  Future<UserModel> getCurrnetUserInfo() async {
    final user =
        await _fireStoreService.accountRef.doc(_auth.currentUser!.uid).get();
    log(_auth.currentUser!.uid);
    return UserModel.fromMap(user.data() ?? {});
  }

  Future<String> getId() async {
    String userId = '';
    if (_auth.currentUser != null) {
      userId = _auth.currentUser!.uid;
    }

    return userId;
  }

  // @override
  // Future<String> uploadUserImage(File imageFile) async {
  //   final ref =
  //       _fireBaseStorage.ref().child('profile_images').child('${getId()}.jpg');
  //   await ref.putFile(imageFile);
  //   return ref.getDownloadURL();
  // }
  // @override
  // Future<DataModel> uploadUserImage(UploadImageParam param) async {
  //   final formData = FormData.fromMap({
  //     'file': await MultipartFile.fromFile(param.file.path,
  //         filename: param.file.path.split('/').last),
  //     'file_type': param.fileType, // Assuming your API expects this key
  //   });
  //   log(formData.toString());
  //   final resp = await _dioServcies.sendData(SendDataParam(
  //     url:
  //         'https://zegbackdjango-production.up.railway.app/upload/', // Ensure this is correct

  //     data: formData, // Pass the formData here
  //   ));

  //   final jsonResponse = resp.data as Map<String, dynamic>;

  //   return DataModel.fromMap(jsonResponse);

  //   // final resp = await _dioServcies.sendData(SendDataParam(
  //   //     url: 'https://zegbackdjango-production.up.railway.app/upload/',
  //   //     header: const {},
  //   //     data: {'file': file, 'file_type': 'image'}));
  //   // return resp;
  // }

  @override
  Future<void> updateUserProfileSave() async {
    return await _fireStoreService.accountRef
        .doc(_auth.currentUser!.uid)
        .update({UserKeys.isSaved: true});
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    final users = await _fireStoreService.accountRef.get();
    return users.docs
        .map(
          (account) => UserModel.fromMap(account.data()),
        )
        .toList();
  }

  @override
  Future<DataModel> uploadUserImage(UploadImageParam param) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(param.file.path,
          filename: param.file.path.split('/').last),
      'file_type': param.fileType, // Assuming your API expects this key
    });
    log(formData.toString());
    final resp = await _dioServcies.sendData(SendDataParam(
      url:
          'https://zegbackdjango-production.up.railway.app/upload/', // Ensure this is correct

      data: formData, // Pass the formData here
    ));

    final jsonResponse = resp.data as Map<String, dynamic>;

    return DataModel.fromMap(jsonResponse);

    // final resp = await _dioServcies.sendData(SendDataParam(
    //     url: 'https://zegbackdjango-production.up.railway.app/upload/',
    //     header: const {},
    //     data: {'file': file, 'file_type': 'image'}));
    // return resp;
  }

  @override
  Future<List<ArticleModel>> getArticles() async {
    final result = await _fireStoreService.articleRef.get();
    return result.docs.map(
      (e) {
        return ArticleModel.fromMap(e.data());
      },
    ).toList();
  }

  @override
  Future<List<VideoModel>> getVideos() async {
    final result = await _fireStoreService.videoRef.get();
    return result.docs.map(
      (e) {
        return VideoModel.fromMap(e.data());
      },
    ).toList();
  }

  @override
  Future<bool> updateArticleFav(bool val, String name) async {
    log(name);
    await _fireStoreService.articleRef
        .doc(name)
        .update({ArticleKeys.isFav: val});
    return val;
  }

  @override
  Future<void> updateVidFav(bool val, String name) async {
    await _fireStoreService.videoRef.doc(name).update({VideoKeys.isFav: val});
  }

  @override
  Future<List<dynamic>> getFavorites() async {
    List<dynamic> favorites = [];

    final resultv = await _fireStoreService.videoRef
        .where(VideoKeys.isFav, isEqualTo: true)
        .get();

    final List<VideoModel> favoriteVideos =
        resultv.docs.map((e) => VideoModel.fromMap(e.data())).toList();

    favorites.addAll(favoriteVideos);

    final resultar = await _fireStoreService.articleRef
        .where(ArticleKeys.isFav, isEqualTo: true)
        .get();

    final List<ArticleModel> favoriteArticles =
        resultar.docs.map((e) => ArticleModel.fromMap(e.data())).toList();

    favorites.addAll(favoriteArticles);
    log(favorites.toString());
    return favorites;
  }
  // @override
  // Future<void> updatUserStatus(bool isOnline) async {
  //   if (_auth.currentUser != null) {
  //     await _fireStoreService.accountRef.doc(_auth.currentUser!.uid).update({
  //       AccountKeys.isOnline: isOnline,
  //       AccountKeys.lastSeen:
  //           isOnline ? null : DateTime.now().millisecondsSinceEpoch
  //     });
  //   }
  // }

  // @override
  // Stream<bool> getUserStatus(String uid) {
  //   return _fireStoreService.accountRef
  //       .doc(uid)
  //       .snapshots()
  //       .map((snapshot) => snapshot.data()![AccountKeys.isOnline]);
  // }

  // @override
  // Stream<int?> getUserLasSeen(String uid) {
  //   return _fireStoreService.accountRef
  //       .doc(uid)
  //       .snapshots()
  //       .map((snapshot) => snapshot.data()?[AccountKeys.lastSeen] as int?);
  // }
}
