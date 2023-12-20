/// класс библиотек
class Libriry {
  int id;
  String name;
  String address;
  String phone;
  String region;
  double longitude;
  double latitude;

  Libriry({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.longitude,
    required this.latitude,
    required this.region,
  });

  factory Libriry.fromJson(Map<String, dynamic> data) {
    return Libriry(
      id: data['id'] as int,
      name: data['name'] as String,
      address: data['adress'] as String,
      phone: data['phone'] as String,
      longitude: data['longitude'] as double,
      latitude: data['latitude'] as double,
      region: data['region'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'adress': address,
      'phone': phone,
      'longitude': longitude,
      'latitude': latitude,
      'region': region,
    };
  }

  factory Libriry.initial() {
    return Libriry(
      id: 0,
      name: '',
      address: '',
      phone: '',
      longitude: 0.0,
      latitude: 0.0,
      region: '',
    );
  }
}
