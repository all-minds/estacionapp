import 'package:cloud_firestore/cloud_firestore.dart';

class Occupation {
  final String id;
  final Timestamp at;
  final String parkingLotId;
  final String userId;

  DocumentReference? reference;

  Occupation(
      {required this.id,
      required this.at,
      required this.parkingLotId,
      required this.userId});

  //Extension: extensão de um tipo primitivo, permitindo sua customização. A partir dessa extensão, todos desse tipo primitivo incorporarão os atributos/métodos da extensão
  Occupation.fromMap(Map<String, dynamic> map, {this.reference})
      : id = map['id'],
        at = map['at'],
        parkingLotId = map['parking_lot_id'],
        userId = map['user_id'];

  Occupation.fromSnapshot(QueryDocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);

  Map<String, dynamic> toJson() =>
      {"id": id, "at": at, "parking_lot_id": parkingLotId, "user_id ": userId};
}
