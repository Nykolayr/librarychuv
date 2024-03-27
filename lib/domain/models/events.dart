import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:intl/intl.dart';
import 'package:librarychuv/common/constants.dart';
import 'package:librarychuv/domain/models/abstract.dart';
import 'package:librarychuv/domain/models/pagination.dart';

/// класс новостей для страницы
class EventsLibPage {
  List<EventsLib> events;
  Pagination pagination;
  EventsLibPage({
    required this.events,
    required this.pagination,
  });

  /// конечная ли страница
  bool get isLastPage => pagination.currentPage == pagination.pageCount;

  factory EventsLibPage.fromJsonApi(
      Map<String, dynamic> json, EventsLibPage event) {
    List<dynamic> items = (json)['Items'];
    List<Map<String, dynamic>> mappedList = items.map((item) {
      return Map<String, dynamic>.from(item);
    }).toList();
    List<EventsLib> nextEvents =
        mappedList.map((item) => EventsLib.fromJsonApi(item)).toList();
    Logger.e('length  ${event.events.length} ${nextEvents.length}');
    return EventsLibPage(
      events: [...event.events, ...nextEvents],
      pagination: json['pagination'] == null
          ? Pagination.init()
          : Pagination.fromJson(json['pagination']),
    );
  }

  factory EventsLibPage.fromJson(Map<String, dynamic> json) {
    return EventsLibPage(
      events: json['data'] == null
          ? []
          : (json['data'] as List)
              .map((e) => EventsLib.fromJson(e as Map<String, dynamic>))
              .toList(),
      pagination: json['pagination'] == null
          ? Pagination.init()
          : Pagination.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = events.map((v) => v.toJson()).toList();
    data['pagination'] = pagination.toJson();

    return data;
  }

  factory EventsLibPage.init() => EventsLibPage(
        events: [],
        pagination: Pagination.init(),
      );
}

/// класс событий
class EventsLib extends AllModels {
  TypeEvents type;
  String adress;
  String detailText;
  String previewText;
  String previewImage;
  String detailImage;
  String iBlocId;
  EventsLib({
    required super.id,
    required super.name,
    required super.description,
    required super.pathImage,
    required super.date,
    required this.type,
    required this.adress,
    required this.detailText,
    required this.previewText,
    required this.previewImage,
    required this.detailImage,
    required this.iBlocId,
  });

  factory EventsLib.fromJsonApi(Map<String, dynamic> data) {
    Map<String, dynamic> fields = data['Fields'] as Map<String, dynamic>;
    Map<String, dynamic> properties =
        data['Properties'] as Map<String, dynamic>;

    DateFormat dateFormat = DateFormat("dd.MM.yyyy HH:mm:ss");
    dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime dateActive = dateFormat.parse(fields['ACTIVE_FROM_X']);
    String pathImage = fields['PREVIEW_PICTURE'] == null
        ? ''
        : url + fields['PREVIEW_PICTURE'];
    return EventsLib(
      id: fields['ID'] ?? '0',
      iBlocId: fields['IBLOCK_ID'] ?? '0',
      name: fields['NAME'] ?? '',
      description: fields['DETAIL_TEXT'] ?? '',
      previewText: fields['PREVIEW_TEXT'] ?? '',
      pathImage: pathImage,
      date: dateActive,
      detailText: fields['DETAIL_TEXT'] ?? '',
      previewImage: fields['PREVIEW_PICTURE'] ?? '',
      detailImage: fields['DETAIL_PICTURE'] ?? '',
      type: TypeEvents.all,
      adress: properties['ADDRESS'] ?? '',
    );
  }

  factory EventsLib.fromJson(Map<String, dynamic> data) {
    return EventsLib(
      id: data['id'] ?? '0',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      pathImage: data['pathImage'] ?? '',
      date:
          data['date'] == null ? DateTime.now() : DateTime.parse(data['date']),
      type: data['type'] == null
          ? TypeEvents.all
          : TypeEvents.values.firstWhere(
              (element) => element.name == data['type'],
            ),
      adress: data['adress'] ?? '',
      detailText: data['detailText'] ?? '',
      previewText: data['previewText'] ?? '',
      previewImage: data['previewImage'] ?? '',
      detailImage: data['detailImage'] ?? '',
      iBlocId: data['iBlocId'] ?? '0',
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
      'type': type.name,
      'adress': adress,
      'detailText': detailText,
      'previewText': previewText,
      'previewImage': previewImage,
      'detailImage': detailImage,
      'iBlocId': iBlocId,
    };
  }

  factory EventsLib.initial() {
    return EventsLib(
      id: '0',
      name: '',
      description: '',
      pathImage: '',
      date: DateTime.now(),
      type: TypeEvents.all,
      adress: '',
      detailText: '',
      previewText: '',
      previewImage: '',
      detailImage: '',
      iBlocId: '0',
    );
  }
}

enum TypeEvents {
  all,
  presentations,
  meetings,
  masters,
  club,
  exhibitions,
  online,
  other;

  String get title => switch (this) {
        TypeEvents.all => 'Все',
        TypeEvents.presentations => 'Презентации',
        TypeEvents.meetings => 'Встречи',
        TypeEvents.masters => 'Мастер-классы',
        TypeEvents.club => 'Клубы по интересам',
        TypeEvents.exhibitions => 'Выставки',
        TypeEvents.online => 'Онлайн мероприятия',
        TypeEvents.other => 'Другое',
      };
}
