import 'package:cloud_firestore/cloud_firestore.dart';

class ParkingRepository {
  static Stream<QuerySnapshot<Map<String, dynamic>>> listParkings() {
    return FirebaseFirestore.instance
        .collection("parkings")
        .snapshots();
  }
}