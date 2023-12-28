import 'package:flutter/material.dart';
import 'package:books_crud/models/Idol.dart';

class IdolRecordDetail extends StatelessWidget {
  // In the constructor, require a Todo.
  const IdolRecordDetail({super.key, required this.idol});

  // Declare a field that holds the Todo.
  final Idol idol;

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(idol.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(idol.nationality),
      ),
    );
  }
}
