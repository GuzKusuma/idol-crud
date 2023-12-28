class IdolRecord {
  final int id;
  final String title;

  const IdolRecord({required this.id, required this.title});

  factory IdolRecord.fromJson(Map<String, dynamic> json) {
    return IdolRecord(
      id: json['id'],
      title: json['title'],
    );
  }
}
