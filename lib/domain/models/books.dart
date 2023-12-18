class Book {
  int id;
  String title;
  String description;
  String pathImage;
  String url;
  DateTime date;

  Book(
      {required this.id,
      required this.title,
      required this.description,
      required this.pathImage,
      required this.date,
      required this.url});

  factory Book.fromJson(Map<String, dynamic> data) {
    return Book(
      id: data['id'] as int,
      title: data['title'] as String,
      description: data['description'] as String,
      pathImage: data['pathImage'] as String,
      date: DateTime.parse(data['date'] as String),
      url: data['url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'pathImage': pathImage,
      'date': date.toIso8601String(),
      'url': url
    };
  }

  factory Book.initial() {
    return Book(
      id: 0,
      title: '',
      description: '',
      pathImage: '',
      date: DateTime.now(),
      url: '',
    );
  }
}
