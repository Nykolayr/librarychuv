import 'package:librarychuv/domain/models/abstract.dart';

class News extends AllModels {
  News(
      {required super.id,
      required super.name,
      required super.description,
      required super.pathImage,
      required super.date});

  factory News.fromJson(Map<String, dynamic> data) {
    return News(
      id: data['id'] as int,
      name: data['name'] as String,
      description: data['description'] as String,
      pathImage: data['pathImage'] as String,
      date: DateTime.parse(data['date'] as String),
    );
  }
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

  factory News.initial() {
    return News(
      id: 0,
      name: '',
      description: '',
      pathImage: '',
      date: DateTime.now(),
    );
  }
}
