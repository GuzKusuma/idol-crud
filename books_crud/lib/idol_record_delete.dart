import 'package:flutter/material.dart';
import 'package:books_crud/models/Idol.dart';
import 'package:books_crud/my_idol_list_screen.dart';
import 'package:books_crud/services/api.dart';

class IdolRecordDelete extends StatelessWidget {
  // In the constructor, require a Todo.
  const IdolRecordDelete({super.key, required this.idol});

  // Declare a field that holds the Todo.
  final Idol idol;

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(idol.name),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Are you sure to delete idol ${idol.name}?',
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyIdolListScreen()),
                    );
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Yes'),
                  onPressed: () {
                    API.deleteIdolRecord(idol.id.toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyIdolListScreen()),
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
