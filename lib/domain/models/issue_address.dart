import 'package:librarychuv/domain/models/abstract.dart';

/// адресса выдачи
class IssueAddress extends ParentModels {
  String adress;

  IssueAddress({
    required this.adress,
    required super.id,
    required super.name,
  });

  factory IssueAddress.fromJson(Map<String, dynamic> data) => IssueAddress(
        id: data['id'],
        adress: data['adress'],
        name: data['name'],
      );
  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'adress': adress,
        'name': name,
      };

  factory IssueAddress.initial() {
    return IssueAddress(id: 0, adress: '', name: '');
  }
}
