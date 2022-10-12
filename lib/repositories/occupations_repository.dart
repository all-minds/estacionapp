import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estacionapp/models/occupation.dart';

class OccupationsRepository {
  static List<Occupation> getOccupations(String parkingId) {
    try {
      Stream<QuerySnapshot> querySnapshot = FirebaseFirestore.instance
          .collection("parkings")
          .doc(parkingId)
          .collection("occupations")
          .snapshots();

      List<Occupation> result = [];

      querySnapshot.forEach((element) {
        element.docs.forEach((doc) {
          result.add(Occupation.fromSnapshot(doc));
        });
      });

      return result;
    } catch (error) {
      throw Exception();
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> listOccupations(
      String parkingId) {
    return FirebaseFirestore.instance
        .collection("parkings")
        .doc(parkingId)
        .collection("occupations")
        .snapshots();
  }
}
