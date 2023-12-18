class News {
  int id;
  String title;
  String description;
  String pathImage;
  DateTime date;

  News(
      {required this.id,
      required this.title,
      required this.description,
      required this.pathImage,
      required this.date});

  factory News.fromJson(Map<String, dynamic> data) {
    return News(
      id: data['id'] as int,
      title: data['title'] as String,
      description: data['description'] as String,
      pathImage: data['pathImage'] as String,
      date: DateTime.parse(data['date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'pathImage': pathImage,
      'date': date.toIso8601String(),
    };
  }

  factory News.initial() {
    return News(
      id: 0,
      title: '',
      description: '',
      pathImage: '',
      date: DateTime.now(),
    );
  }
}
