import 'package:librarychuv/domain/models/abstract.dart';

class EventsLib extends AllModels {
  TypeEvents type;
  EventsLib({
    required super.id,
    required super.name,
    required super.description,
    required super.pathImage,
    required super.date,
    required this.type,
  });

  factory EventsLib.fromJson(Map<String, dynamic> data) => EventsLib(
        id: data['id'] as int,
        name: data['name'] as String,
        description: data['description'] as String,
        pathImage: data['pathImage'] as String,
        date: DateTime.parse(data['date'] as String),
        type: TypeEvents.values
            .firstWhere((element) => element.name == (data['type'] as String)),
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pathImage': pathImage,
      'date': date.toIso8601String(),
      'type': type.name,
    };
  }

  factory EventsLib.initial() {
    return EventsLib(
      id: 0,
      name: '',
      description: '',
      pathImage: '',
      date: DateTime.now(),
      type: TypeEvents.presentations,
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
