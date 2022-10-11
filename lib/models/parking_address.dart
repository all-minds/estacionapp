class ParkingAddress {
  final String streetName;
  final String neighborhood;
  final String zipCode;
  final String country;
  final String number;
  final String city;
  final String stateCode;
  final String? complement;

  ParkingAddress(
      {required this.streetName,
      required this.neighborhood,
      required this.zipCode,
      required this.country,
      required this.number,
      required this.city,
      required this.stateCode,
      this.complement});
}
