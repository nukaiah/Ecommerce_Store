import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetUser {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static String uid = auth.currentUser.uid;
  static Query getCurrentUser =
      firestore.collection('UsersData').where("uid", isEqualTo: uid);
}
