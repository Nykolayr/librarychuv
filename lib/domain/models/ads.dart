import 'package:librarychuv/domain/models/abstract.dart';

class Ads extends AllModels {
  Ads(
      {required super.id,
      required super.name,
      required super.description,
      required super.pathImage,
      required super.date});

  factory Ads.fromJson(Map<String, dynamic> data) => Ads(
        id: data['id'] as int,
        name: data['name'] as String,
        description: data['description'] as String,
        pathImage: data['pathImage'] as String,
        date: DateTime.parse(data['date'] as String),
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pathImage': pathImage,
      'date': date.toIso8601String(),
    };
  }

  factory Ads.initial() {
    return Ads(
      id: 0,
      name: '',
      description: '',
      pathImage: '',
      date: DateTime.now(),
    );
  }
}
