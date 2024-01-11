import 'package:librarychuv/domain/models/abstract.dart';

class News extends AllModels {
  int showCount;
  News({
    required super.id,
    required super.name,
    required super.description,
    required super.pathImage,
    required super.date,
    required this.showCount,
  });

  factory News.fromJson(Map<String, dynamic> data) => News(
        id: data['id'] as int,
        name: data['name'] as String,
        description: data['description'] as String,
        pathImage: data['pathImage'] as String,
        date: DateTime.parse(data['date'] as String),
        showCount: data['showCount'] as int,
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pathImage': pathImage,
      'date': date.toIso8601String(),
      'showCount': showCount
    };
  }

  factory News.initial() {
    return News(
      id: 0,
      name: '',
      description: '',
      pathImage: '',
      date: DateTime.now(),
      showCount: 0,
    );
  }
}

/// класс тематики новостей
class SubjectNews extends ParentModels {
  SubjectNews({required super.id, required super.name});
  factory SubjectNews.fromJson(Map<String, dynamic> data) => SubjectNews(
        id: data['id'] as int,
        name: data['name'] as String,
      );

  @override
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  factory SubjectNews.initial() {
    return SubjectNews(id: 0, name: '');
  }
}
