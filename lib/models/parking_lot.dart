import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estacionapp/models/parking_lot_tag.dart';

class ParkingLot {
  final String id;
  final String floor;
  final bool isAvailable;
  final String number;
  final ParkingLotTag? tag;
  Timestamp? occupiedAt;
  String? occupantId;

  DocumentReference? reference;

  ParkingLot(
      {required this.id,
      required this.floor,
      required this.isAvailable,
      required this.number,
      this.tag,
      this.occupantId,
      this.occupiedAt});

  //Extension: extensão de um tipo primitivo, permitindo sua customização. A partir dessa extensão, todos desse tipo primitivo incorporarão os atributos/métodos da extensão
  ParkingLot.fromMap(Map<String, dynamic> map, {this.reference})
      : id = map['id'],
        floor = map['floor'],
        isAvailable = map['is_available'],
        number = map['number'],
        tag = ParkingLotTag.values.byName(map['tag']),
        occupiedAt = map['occupied_at'],
        occupantId = map['occupant_id'];

  ParkingLot.fromSnapshot(QueryDocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);

  Map<String, dynamic> toJson() => {
        "id": id,
        "floor": floor,
        "is_available": isAvailable,
        "number": number,
        "tag": tag?.name,
        "occupied_at": occupiedAt,
        "occupant_id": occupantId
      };
}
