class Region {
  int id;
  String name;

  Region({required this.id, required this.name});

  factory Region.fromJson(Map<String, dynamic> data) {
    return Region(
      id: data['id'] as int,
      name: data['name'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  factory Region.initial() {
    return Region(
      id: 0,
      name: '',
    );
  }
}
