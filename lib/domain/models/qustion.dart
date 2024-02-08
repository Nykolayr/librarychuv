import 'package:flutter/material.dart';
import 'package:librarychuv/domain/models/abstract.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

class Question extends ParentModels {
  final String question;
  final String email;
  final String answer;
  final String operator;

  Question({
    required super.id,
    required super.name,
    required this.question,
    required this.email,
    required this.answer,
    required this.operator,
  });

  factory Question.fromJson(Map<String, dynamic> data) => Question(
        id: data['id'],
        name: data['name'],
        question: data['question'],
        email: data['email'],
        answer: data['answer'],
        operator: data['operator'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'question': question,
        'email': email,
        'answer': answer,
        'operator': operator
      };

  factory Question.initial() {
    return Question(
      id: 0,
      name: '',
      question: '',
      email: '',
      answer: '',
      operator: '',
    );
  }
}

enum TypeQuestion {
  awaitingRes,
  resRecive;

  String get title => switch (this) {
        TypeQuestion.awaitingRes => 'Ожидает ответа',
        TypeQuestion.resRecive => 'Ответ получен',
      };
  Widget get baner => TypeQuestionWidget(type: this);

  Color get color => switch (this) {
        TypeQuestion.resRecive => AppColor.darkGreen,
        TypeQuestion.awaitingRes => AppColor.redMain,
      };
}

class TypeQuestionWidget extends StatelessWidget {
  const TypeQuestionWidget({super.key, required this.type});
  final TypeQuestion type;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: AppColor.fonBaner,
          borderRadius: AppDif.borderRadius5,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(type.title,
            style: AppText.text12b.copyWith(color: type.color)));
  }
}
