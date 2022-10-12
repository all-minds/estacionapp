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

  ParkingAddress.fromMap(Map<String, dynamic> map)
      : streetName = map['street_name'],
        neighborhood = map['neighborhood'],
        zipCode = map['zip_code'],
        country = map['country'],
        number = map['number'],
        city = map['city'],
        stateCode = map['state_code'],
        complement = map['complement'];
  
  Map<String, dynamic> toJson() => {
    'street_name' : streetName,
    'neighborhood' : neighborhood,
    'zip_code' : zipCode,
    'country' : country,
    'number' : number,
    'city' : city,
    'state_code' : stateCode,
    'complement' : complement
  };
}
