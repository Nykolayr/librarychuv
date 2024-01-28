import 'package:librarychuv/domain/models/abstract.dart';
import 'package:librarychuv/domain/models/events.dart';

/// модель моих событий
class MyEvents extends ParentModels {
  EventsLib event;

  MyEvents({
    required super.id,
    required super.name,
    required this.event,
  });

  factory MyEvents.fromJson(Map<String, dynamic> data) {
    EventsLib event = EventsLib.fromJson(data['event']);
    return MyEvents(
      id: data['id'] as int,
      name: event.name,
      event: event,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'id': id, 'event': event.toJson(), 'name': name};
  }

  factory MyEvents.inicial() {
    return MyEvents(id: 0, event: EventsLib.initial(), name: '');
  }
}
