import 'package:librarychuv/domain/models/abstract.dart';

/// класс библиотек

class Libriry extends ParentModels {
  String longName;
  String address;
  String phone;
  String region;
  double longitude;
  double latitude;
  String link;
  String supervisor;
  String email;
  String otvetstv;
  String image;

  Libriry({
    required super.id,
    required super.name,
    required this.address,
    required this.phone,
    required this.longitude,
    required this.latitude,
    required this.region,
    required this.link,
    required this.longName,
    required this.supervisor,
    required this.email,
    required this.otvetstv,
    required this.image,
  });

  factory Libriry.fromJson(Map<String, dynamic> data) {
    String coor = data['COORDINATES'];
    List<String> coord = coor.split(',');
    double longitude = double.parse(coord[0]);
    double latitude = double.parse(coord[1]);
    return Libriry(
      id: data['id'] as String,
      name: data['NAME'] as String,
      address: data['ADDRESS'] as String,
      phone: data['PHONE'] as String,
      longitude: longitude,
      latitude: latitude,
      region: data['AREA'] as String,
      link: data['LINK'] as String,
      longName: data['LONG_NAME'] as String,
      supervisor: data['SUPERVISOR'] as String,
      email: data['EMAIL'] as String,
      otvetstv: data['OTVETSV'] as String,
      image: data['IMAGE'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'NAME': name,
      'ADDRESS': address,
      'PHONE': phone,
      'COORDINATES': '$longitude,$latitude',
      'AREA': region,
      'LINK': link,
      'LONG_NAME': longName,
      'SUPERVISOR': supervisor,
      'EMAIL': email,
      'OTVETSV': otvetstv,
      'IMAGE': image,
    };
  }

  factory Libriry.initial() {
    return Libriry(
      id: '0',
      name: '',
      address: '',
      phone: '',
      longitude: 0.0,
      latitude: 0.0,
      region: '',
      link: '',
      longName: '',
      supervisor: '',
      email: '',
      otvetstv: '',
      image: '',
    );
  }
}
