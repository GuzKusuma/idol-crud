class Book {
  late int id;
  late String Judul, Deskripsi;

  Book({
    required this.id,
    required this.Judul,
    required this.Deskripsi,
  });

  Book.fromJson(Map json)
      : id = json['id'],
        Judul = json['Judul'],
        Deskripsi = json['Deskripsi'];

  Map toJson() {
    return {
      'id': id,
      'Judul': Judul,
      'Deskripsi': Deskripsi,
    };
  }
}
