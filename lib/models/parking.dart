import 'package:estacionapp/models/parking_address.dart';

class Parking {
  final String id;
  final String? description;
  final ParkingAddress address;
  final String endTime;

  Parking(
      {required this.address,
      required this.id,
      this.description,
      required this.endTime});
}
