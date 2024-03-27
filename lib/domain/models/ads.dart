import 'package:librarychuv/domain/models/abstract.dart';

import 'package:librarychuv/domain/models/pagination.dart';

/// класс объявлений для страницы
class AdsForPage {
  List<Ads> ads;
  Pagination pagination;
  int currentPage;
  AdsForPage(
      {required this.ads, required this.pagination, required this.currentPage});

  factory AdsForPage.fromJson(Map<String, dynamic> json) {
    return AdsForPage(
      ads: json['data'] == null
          ? []
          : (json['data'] as List)
              .map((e) => Ads.fromJson(e as Map<String, dynamic>))
              .toList(),
      pagination: json['pagination'] == null
          ? Pagination.init()
          : Pagination.fromJson(json['pagination']),
      currentPage: json['currentPage'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = ads.map((v) => v.toJson()).toList();
    data['pagination'] = pagination.toJson();
    data['currentPage'] = currentPage;
    return data;
  }

  factory AdsForPage.init() => AdsForPage(
        ads: [],
        pagination: Pagination.init(),
        currentPage: 1,
      );
}

/// класс объявлений
class Ads extends AllModels {
  Ads(
      {required super.id,
      required super.name,
      required super.description,
      required super.pathImage,
      required super.date});

  factory Ads.fromJson(Map<String, dynamic> data) => Ads(
        id: data['id'] as String,
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
      id: '0',
      name: '',
      description: '',
      pathImage: '',
      date: DateTime.now(),
    );
  }
}
