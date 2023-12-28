// TODO Implement this library.// ignore: file_names
class Model {
  final int id;
  final String name;
  final String author;
  final String description;

  Model(
      {required this.id,
      required this.name,
      required this.author,
      required this.description});

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
        id: json['id'],
        name: json['name'],
        author: json['author'],
        description: json['description']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'author': author,
      'descritpion': description,
    };
  }
}
