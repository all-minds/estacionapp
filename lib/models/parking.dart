import 'package:estacionapp/models/parking_address.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Parking {
  final String id;
  final String label;
  final String? description;
  final ParkingAddress address;
  final String endTime;

  DocumentReference? reference;

  Parking(
      {required this.id,
      required this.label,
      this.description,
      required this.address,      
      required this.endTime});

  Parking.fromMap(Map<String, dynamic> map, {this.reference})
      : id = map['id'],
        label = map['label'],
        description = map['description'],
        address = ParkingAddress.fromMap(map['address']),
        endTime = map['end_time'];

  Parking.fromSnapshot(QueryDocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>, reference: snapshot.reference);

  Map<String, dynamic> toJson() => {
    'id' : id,
    'label' : label,
    'description' : description,
    'parking_address' : address,   
    'end_time' : endTime    
  };
}
