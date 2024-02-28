import 'package:librarychuv/domain/models/abstract.dart';

class Help extends ParentModels {
  final String answer;
  final bool isRed;

  Help({
    required this.answer,
    required this.isRed,
    required super.id,
    required super.name,
  });

  factory Help.fromJson(Map<String, dynamic> data) => Help(
        id: data['id'],
        name: data['name'],
        answer: data['answer'],
        isRed: data['isRed'],
      );

  @override
  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'answer': answer, 'isRed': isRed};

  factory Help.initial() {
    return Help(
      id: '0',
      name: '',
      answer: '',
      isRed: false,
    );
  }
}
