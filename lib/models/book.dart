class Book {
  late int id;
  late String name, author, description;

  Book({
    required this.id,
    required this.name,
    required this.author,
    required this.description,
  });

  Book.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        author = json['author'],
        description = json['deskripsi'];

  Map toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}
