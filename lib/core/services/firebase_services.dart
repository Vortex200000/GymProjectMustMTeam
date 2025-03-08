import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseService {
  final accountRef =
      FirebaseFirestore.instance.collection('accounts_collection');
  final articleRef =
      FirebaseFirestore.instance.collection('articles_collection');
  final videoRef = FirebaseFirestore.instance.collection('videos_collection');
}
