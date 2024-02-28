import 'package:flutter/material.dart';
import 'package:librarychuv/domain/models/abstract.dart';
import 'package:librarychuv/domain/models/books.dart';
import 'package:librarychuv/domain/models/issue_address.dart';
import 'package:librarychuv/presentation/theme/theme.dart';

class BookOrder extends ParentModels {
  IssueAddress adress;
  Book book;
  String comment;
  TypeOrder type;
  DateTime date;
  BookOrder({
    required this.adress,
    required this.book,
    required super.id,
    required super.name,
    required this.comment,
    required this.type,
    required this.date,
  });

  factory BookOrder.fromJson(Map<String, dynamic> data) => BookOrder(
        adress: IssueAddress.fromJson(data['adress']),
        book: Book.fromJson(data['book']),
        id: data['id'],
        name: data['name'],
        comment: data['comment'],
        type: TypeOrder.values.firstWhere(
          (element) => element.name == data['type'],
        ),
        date: DateTime.parse(data['date']),
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'adress': adress.toJson(),
        'book': book.toJson(),
        'comment': comment,
        'type': type.name,
        'date': date.toIso8601String(),
      };

  factory BookOrder.initial() {
    return BookOrder(
      adress: IssueAddress.initial(),
      book: Book.initial(),
      id: '0',
      name: '',
      comment: '',
      type: TypeOrder.inProcessing,
      date: DateTime.now(),
    );
  }
}

enum TypeOrder {
  readyIssued,
  refused,
  inDelivery,
  inProcessing,
  cancel;

  String get title => switch (this) {
        TypeOrder.readyIssued => 'Готов к выдаче',
        TypeOrder.refused => 'Отказ',
        TypeOrder.inDelivery => 'В доставке',
        TypeOrder.cancel => 'Отменен',
        TypeOrder.inProcessing => 'В обработке',
      };
  Widget get baner => TypeOrderWidget(type: this);
  Color get color => switch (this) {
        TypeOrder.readyIssued => AppColor.darkGreen,
        TypeOrder.refused => AppColor.redMain,
        TypeOrder.inDelivery => AppColor.darkGreen,
        TypeOrder.cancel => AppColor.redMain,
        TypeOrder.inProcessing => AppColor.blackText,
      };
}

class TypeOrderWidget extends StatelessWidget {
  const TypeOrderWidget({super.key, required this.type});
  final TypeOrder type;
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
