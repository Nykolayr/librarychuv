import 'package:librarychuv/domain/models/abstract.dart';

class Region extends ParentModels {
  Region({required super.id, required super.name});

  factory Region.fromJson(Map<String, dynamic> data) {
    return Region(
      id: data['id'] as String,
      name: data['name'] as String,
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  factory Region.initial() {
    return Region(
      id: '0',
      name: '',
    );
  }
}
