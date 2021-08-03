import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  static searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection('Products')
        .where('name', isEqualTo: searchField)
        .snapshots();
  }
}
