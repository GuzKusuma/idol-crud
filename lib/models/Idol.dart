class Idol {
  late int id;
  late String name;
  late String position;
  late String nationality;

  Idol(int id, String name, String position, String nationality) {
    this.id = id;
    this.name = name;
    this.position = position;
    this.nationality = nationality;
  }

  Idol.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        position = json['position'],
        nationality = json['nationality'];

  Map toJson() {
    return {
      'id': id,
      'name': name,
      'position': position,
      'nationality': nationality
    };
  }
}
