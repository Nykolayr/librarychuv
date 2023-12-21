import 'package:librarychuv/domain/models/abstract.dart';

/// класс библиотек

class Libriry extends ParentModels {
  String address;
  String phone;
  String region;
  double longitude;
  double latitude;

  Libriry({
    required super.id,
    required super.name,
    required this.address,
    required this.phone,
    required this.longitude,
    required this.latitude,
    required this.region,
  });

  factory Libriry.fromJson(Map<String, dynamic> data) => Libriry(
        id: data['id'] as int,
        name: data['name'] as String,
        address: data['adress'] as String,
        phone: data['phone'] as String,
        longitude: data['longitude'] as double,
        latitude: data['latitude'] as double,
        region: data['region'] as String,
      );

  @override
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
