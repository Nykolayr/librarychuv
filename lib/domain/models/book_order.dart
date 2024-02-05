import 'package:librarychuv/domain/models/abstract.dart';
import 'package:librarychuv/domain/models/books.dart';
import 'package:librarychuv/domain/models/issue_address.dart';

class BookOrder extends ParentModels {
  IssueAddress adress;
  Book book;
  String comment;
  BookOrder({
    required this.adress,
    required this.book,
    required super.id,
    required super.name,
    required this.comment,
  });

  factory BookOrder.fromJson(Map<String, dynamic> data) => BookOrder(
        adress: IssueAddress.fromJson(data['adress']),
        book: Book.fromJson(data['book']),
        id: data['id'],
        name: data['name'],
        comment: data['comment'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'adress': adress.toJson(),
        'book': book.toJson(),
        'comment': comment,
      };

  factory BookOrder.initial() {
    return BookOrder(
      adress: IssueAddress.initial(),
      book: Book.initial(),
      id: 0,
      name: '',
      comment: '',
    );
  }
}
