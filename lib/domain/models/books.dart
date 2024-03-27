import 'package:librarychuv/domain/models/abstract.dart';
import 'package:librarychuv/domain/models/pagination.dart';

/// класс книг для страницы
class BooksForPage {
  List<Book> books;
  Pagination pagination;
  int currentPage;
  BooksForPage(
      {required this.books,
      required this.pagination,
      required this.currentPage});

  factory BooksForPage.fromJson(Map<String, dynamic> json) {
    return BooksForPage(
      books: json['data'] == null
          ? []
          : (json['data'] as List)
              .map((e) => Book.fromJson(e as Map<String, dynamic>))
              .toList(),
      pagination: json['pagination'] == null
          ? Pagination.init()
          : Pagination.fromJson(json['pagination']),
      currentPage: json['currentPage'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = books.map((v) => v.toJson()).toList();
    data['pagination'] = pagination.toJson();
    data['currentPage'] = currentPage;
    return data;
  }

  factory BooksForPage.init() => BooksForPage(
        books: [],
        pagination: Pagination.init(),
        currentPage: 1,
      );
}

/// класс книг
class Book extends AllModels {
  String url;
  bool isFavorite;
  String preface;
  Book({
    required this.url,
    required super.id,
    required super.name,
    required super.description,
    required super.pathImage,
    required super.date,
    required this.isFavorite,
    required this.preface,
  });
  factory Book.fromJson(Map<String, dynamic> data) => Book(
        id: data['id'] as String,
        name: data['name'] as String,
        description: data['description'] as String,
        pathImage: data['pathImage'] as String,
        date: DateTime.parse(data['date'] as String),
        url: data['url'] as String,
        isFavorite: data['isFavorite'] as bool,
        preface: data['preface'] as String,
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pathImage': pathImage,
      'date': date.toIso8601String(),
      'url': url,
      'isFavorite': isFavorite,
      'preface': preface
    };
  }

  factory Book.initial() {
    return Book(
      id: '0',
      name: '',
      description: '',
      pathImage: '',
      date: DateTime.now(),
      url: '',
      isFavorite: false,
      preface: '',
    );
  }
}
