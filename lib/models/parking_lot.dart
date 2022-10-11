import 'package:estacionapp/models/parking_lot_tag.dart';

class ParkingLot {
  final String id;
  final String floor;
  final bool isAvailable;
  final String number;
  final ParkingLotTag tag;

  ParkingLot(
      {required this.id,
      required this.floor,
      required this.isAvailable,
      required this.number,
      required this.tag});
}
