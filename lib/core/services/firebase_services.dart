import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseService {
  final accountRef =
      FirebaseFirestore.instance.collection('accounts_collection');
}
