abstract class ParentModels {
  String id;
  String name;

  ParentModels({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toJson();
}

abstract class AllModels extends ParentModels {
  String description;
  String pathImage;
  DateTime date;

  AllModels(
      {required super.id,
      required super.name,
      required this.description,
      required this.pathImage,
      required this.date});

  @override
  Map<String, dynamic> toJson();
}
