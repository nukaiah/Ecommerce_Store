import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseQuerys {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Query catQuery = firestore.collection("Catgory");
  static Query carouselQuery = firestore.collection("Carousels");
  static Query featuredQuery = firestore.collection("Featureds");

  static getCatProQuery(String catname) {
    return firestore.collection("Products").where("cat", isEqualTo: catname);
  }

  static getScatProQuery(String scat) {
    return firestore.collection("Products").where("scat", isEqualTo: scat);
  }
}
