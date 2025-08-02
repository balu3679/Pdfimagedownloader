import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';

class CloudStorageCollections {
  final firestore = FirebaseFirestore.instance;
  late final CollectionReference usercollection;
  late final CollectionReference taskcollection;

  String get randomid => randomAlphaNumeric(10);

  CloudStorageCollections() {
    usercollection = firestore.collection('user');
  }
}
