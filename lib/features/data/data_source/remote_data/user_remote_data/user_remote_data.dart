import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mgym/core/services/api_service.dart';
import 'package:mgym/core/services/firebase_services.dart';
import 'package:mgym/core/services/nuteration_service.dart';
import 'package:mgym/features/data/models/article_model.dart';
import 'package:mgym/features/data/models/data_model.dart';
import 'package:mgym/features/data/models/meal_plan_model.dart';
import 'package:mgym/features/data/models/message_model.dart';
import 'package:mgym/features/data/models/user_model.dart';
import 'package:mgym/features/data/models/video_model.dart';
import 'package:mgym/features/domain/entities/user_entity.dart';
import 'package:mgym/features/domain/use_cases/user/upload_user_image_usecase.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// import 'package:app/features/data/models/data_model.dart';

abstract class UserRemoteData {
  Future<UserModel> saveUserProfile(UserModel accountModel);
  Future<UserModel> getUserProfileInfo(String id);
  Future<UserModel> updateUserProfileMap(Map<String, dynamic> map);
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
  Future<List<MealPlanModel>> getUserMealPlansAccToGoal();
  Future<void> setCompletedContent(String titel, String type);
  Stream<int> getUserProgress(String type);
  Future<int> getTotalItems(String collection);
  Stream<List<MessageModel>> getMessages();
  Future<void> sendMessage(MessageModel message);
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
    this._nutirationService,
    // this._dioServcies,
  );
  final FirebaseAuth _auth;
  // final FirebaseFirestore _fireStore;
  final FireBaseService _fireStoreService;
  final DioServcies _dioServcies;
  final NutirationService _nutirationService;

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
  Future<UserModel> updateUserProfileMap(Map<String, dynamic> map) async {
    // log('id =============>${_auth.currentUser!.uid}');
    await _fireStoreService.accountRef.doc(_auth.currentUser!.uid).update(map);
    final result =
        await _fireStoreService.accountRef.doc(_auth.currentUser!.uid).get();
    return UserModel.fromMap(result.data() ?? {});
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

  // }
  @override
  Future<DataModel> uploadUserImage(UploadImageParam param) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(param.file.path,
          filename: param.file.path.split('/').last),
      'upload_preset': 'my_unassigned', // Assuming your API expects this key
    });
    log(formData.toString());
    final resp = await _dioServcies.sendData(SendDataParam(
      url: 'https://api.cloudinary.com/v1_1/dpoqqpqjv/upload',
      // 'https://zegbackdjango-production.up.railway.app/upload/',

      data: formData, // Pass the formData here
    ));

    final jsonResponse = resp.data as Map<String, dynamic>;
    log(jsonResponse.toString());
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

  @override
  Future<List<MealPlanModel>> getUserMealPlansAccToGoal() async {
    // log(_nutirationService.calculateBMR(85, 70, 28, 'male').toString());
    //first we get the current user data
    UserModel user = await _fireStoreService.accountRef
        .doc(_auth.currentUser!.uid)
        .get()
        .then(
      (value) {
        return UserModel.fromMap(value.data() ?? {});
      },
    );
    // next we calculate the bmr
    double bmr = _nutirationService.calculateBMR(
        user.weight.toDouble(), user.hight.toDouble(), user.age, user.gender);
    log(bmr.toString());
    // then we calculate the tdee
    double tdee = _nutirationService.calculateTDEE(bmr, 'moderate');
    log(tdee.toString());
    // Step 3: Adjust Calories Based on Goal
    double adjustedCalories =
        _nutirationService.adjustCaloriesForGoal(tdee, user.goal);
    log(adjustedCalories.toString());

    Map<String, double> macros = _nutirationService.calculateMacros(
        adjustedCalories, user.weight.toDouble(), user.goal);
    log(macros.toString());

    final result = await _fireStoreService.mealRef.get();

    final List<MealPlanModel> dataMeals = result.docs
        .map(
          (e) => MealPlanModel.fromMap(e.data()),
        )
        .toList();

    final List<MealPlanModel> userMeals = getMealPlanSUser(
        macros['protein']!, macros['fats']!, macros['carbs']!, dataMeals);
    log(userMeals.toString());

    return userMeals;
  }

  List<MealPlanModel> getMealPlanSUser(
      double protein, double fats, double carbs, List<MealPlanModel> meals) {
    return meals
        .where(
          (meal) =>
              meal.protein >= (protein * 0.9) &&
              meal.protein <= (protein * 1.1) &&
              meal.fats >= (fats * 0.9) &&
              meal.fats <= (fats * 1.1) &&
              meal.carbs >= (carbs * 0.9) &&
              meal.carbs <= (carbs * 1.1),
        )
        .toList();
  }

  @override
  Future<void> setCompletedContent(String titel, String type) async {
    await _fireStoreService.accountRef
        .doc(_auth.currentUser!.uid)
        .collection('completed_content')
        .add({
      'title': titel,
      'type': type,
      'completed_at': DateTime.now().millisecondsSinceEpoch
    });
  }

  @override
  Stream<int> getUserProgress(String type) {
    return _fireStoreService.accountRef
        .doc(_auth.currentUser!.uid)
        .collection('completed_content')
        .where('type', isEqualTo: type)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  Future<int> getCollectionCount(String collectionPath) async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection(collectionPath).get();
    return snapshot.size; // Returns the number of documents in the collection
  }

  @override
  Future<int> getTotalItems(String collection) async {
    int articlesCount = await getCollectionCount(collection);
    // int videosCount = await getCollectionCount('videos_collection');

    // int totalItems = articlesCount + videosCount;

    // log('Total Articles: $articlesCount');
    // log('Total Videos: $videosCount');
    // log('Total Items to Complete: $totalItems');
    return articlesCount;
  }

  @override
  Future<void> sendMessage(MessageModel message) async {
    await _fireStoreService.messagesCommunity.add(message.toMap());
  }

  @override
  Stream<List<MessageModel>> getMessages() {
    return _fireStoreService.messagesCommunity
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return MessageModel.fromMap(doc.data());
            }).toList());
  }
  // meal.protein >= (protein * 0.9) && meal.protein <= (protein * 1.1) &&
  // meal.fats >= (fats * 0.9) && meal.fats <= (fats * 1.1) &&
  // meal.carbs >= (carbs * 0.9) && meal.carbs <= (carbs * 1.1)

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
