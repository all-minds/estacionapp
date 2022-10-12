import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estacionapp/models/occupation.dart';
import 'package:estacionapp/repositories/occupations_repository.dart';

class ParkingLotsRepository {
  static Stream<QuerySnapshot<Map<String, dynamic>>> listParkingLots(
      String parkingId) {
    return FirebaseFirestore.instance
        .collection("parkings")
        .doc(parkingId)
        .collection("parking_lots")
        .snapshots();
  }

  static int verifyOccupation(
      String parkingLotId, String parkingId, String userId) {
    var occupationStatus = 0;
    List<Occupation> occupations =
        OccupationsRepository.getOccupations(parkingId);
    occupations.forEach((element) {
      if (element.parkingLotId == parkingLotId) {
        if (element.userId == userId) {
          occupationStatus = 1;
        } else {
          occupationStatus = 2;
        }
      }
    });
    return occupationStatus;
  }
}
