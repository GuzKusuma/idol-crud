import 'package:books_crud/screen/home.dart';
import 'package:books_crud/services/book_api.dart';
import 'package:flutter/material.dart';

class UpdateBook extends StatefulWidget {
  const UpdateBook({super.key});

  @override
  State<UpdateBook> createState() => _UpdateBookState();
}

class _UpdateBookState extends State<UpdateBook> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List;

    if (args[1].isNotEmpty) {
      _titleController.text = args[1];
    }
    if (args[2].isNotEmpty) {
      _authorController.text = args[2];
    }
    if (args[3].isNotEmpty) {
      _descriptionController.text = args[3];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Book"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _authorController,
              decoration: const InputDecoration(
                label: Text('author'),
              ),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                label: Text('Description'),
              ),
            ),
            TextButton(
                onPressed: () {
                  BookApi.updateBook(args[0], _titleController.text,
                      _authorController.text, _descriptionController.text);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ));
                },
                child: Text("simpan")),
          ],
        ),
      ),
    );
  }
}
