import 'package:intl/intl.dart';
import 'package:librarychuv/common/constants.dart';
import 'package:librarychuv/domain/models/abstract.dart';

class News extends AllModels {
  int showCount;
  DateTime dateActive;
  String detailText;
  String previewText;
  String previewImage;
  String detailImage;
  News({
    required super.id,
    required super.name,
    required super.description,
    required super.pathImage,
    required super.date,
    required this.showCount,
    required this.dateActive,
    required this.detailText,
    required this.previewText,
    required this.previewImage,
    required this.detailImage,
  });

  factory News.fromJson(Map<String, dynamic> data) {
    return News(
      id: data['id'] as String,
      name: data['name'] as String,
      description: data['description'] as String,
      pathImage: data['pathImage'] as String,
      date: DateTime.parse(data['date'] as String),
      showCount: data['showCount'] ?? 0,
      dateActive: DateTime.parse(data['dateActive'] as String),
      detailText: data['detailText'] as String,
      previewText: data['previewText'] as String,
      previewImage: data['previewImage'] as String,
      detailImage: data['detailImage'] as String,
    );
  }

  factory News.fromJsonApi(Map<String, dynamic> data) {
    Map<String, dynamic> fields = data['Fields'] as Map<String, dynamic>;
    // Map<String, dynamic> properties =
    //     data['Properties'] as Map<String, dynamic>;
    DateFormat dateFormat = DateFormat("dd.MM.yyyy HH:mm:ss");
    DateTime dateTime = dateFormat.parse(fields['DATE_ACTIVE_FROM']);
    dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime dateActive = dateFormat.parse(fields['ACTIVE_FROM_X']);
    String pathImage = url + fields['PREVIEW_PICTURE'];

    return News(
      id: fields['ID'] as String,
      name: fields['NAME'] as String,
      description: fields['DETAIL_TEXT'] as String,
      previewText: fields['PREVIEW_TEXT'] as String,
      pathImage: pathImage,
      date: dateTime,
      showCount: data['showCount'] ?? 0,
      dateActive: dateActive,
      detailText: fields['DETAIL_TEXT'] as String,
      previewImage: fields['PREVIEW_PICTURE'] as String,
      detailImage: fields['DETAIL_PICTURE'] as String,
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
      'showCount': showCount,
      'dateActive': dateActive.toIso8601String(),
      'detailText': detailText,
      'previewText': previewText,
      'previewImage': previewImage,
      'detailImage': detailImage,
    };
  }

  factory News.initial() {
    return News(
      id: '0',
      name: '',
      description: '',
      pathImage: '',
      date: DateTime.now(),
      showCount: 0,
      dateActive: DateTime.now(),
      detailText: '',
      previewText: '',
      previewImage: '',
      detailImage: '',
    );
  }
}

/// класс тематики новостей
class SubjectNews extends ParentModels {
  SubjectNews({required super.id, required super.name});
  factory SubjectNews.fromJson(Map<String, dynamic> data) => SubjectNews(
        id: data['id'] as String,
        name: data['name'] as String,
      );

  @override
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  factory SubjectNews.initial() {
    return SubjectNews(id: '0', name: '');
  }
}
