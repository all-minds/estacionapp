import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estacionapp/models/parking_lot.dart';

class ParkingLotsRepository {
  static Stream<QuerySnapshot<Map<String, dynamic>>> listParkingLots(
      String parkingId) {
    return FirebaseFirestore.instance
        .collection("parkings")
        .doc(parkingId)
        .collection("parking_lots")
        .snapshots();
  }

  static void updateParkingLot(
      ParkingLot pl, String parkingId, String userId, bool isOccupation) async {
    ParkingLot updatedPl = ParkingLot(
        id: pl.id,
        floor: pl.floor,
        isAvailable: !isOccupation,
        number: pl.number,
        tag: pl.tag,
        occupantId: isOccupation ? userId : null,
        occupiedAt: isOccupation ? Timestamp.now() : null);

    FirebaseFirestore.instance
        .collection("parkings")
        .doc(parkingId)
        .collection("parking_lots")
        .doc(pl.id)
        .set(updatedPl.toJson());
  }
}
