// TODO Implement this library.import 'dart:convert';
import 'package:books_crud/books_crud/books_list.dart';
import 'package:books_crud/helper/connection_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BooksUpdate extends StatefulWidget {
  final String slug;

  const BooksUpdate({Key? key, required this.slug}) : super(key: key);

  @override
  _BooksUpdateState createState() => _BooksUpdateState();
}

class _BooksUpdateState extends State<BooksUpdate> {
  final _nameController = TextEditingController();
  final _authorController = TextEditingController();
  final _descriptionsController = TextEditingController();

  Future<void> fetchBookDetails() async {
    try {
      final response = await http.get(
        Uri.parse('${ConnectionConfig.localUrl}/books/${widget.slug}'),
      );

      if (response.statusCode == 200) {
        final bookData = jsonDecode(response.body) as Map<String, dynamic>;

        _nameController.text = bookData['name'] ?? '';
        _authorController.text = bookData['author'] ?? '';
        _descriptionsController.text = bookData['descriptions'] ?? '';
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    fetchBookDetails();
  }

  Future<void> updateBook() async {
    final name = _nameController.text;
    final author = _authorController.text;
    final descriptions = _descriptionsController.text;

    try {
      final response = await http.post(
        Uri.parse('${ConnectionConfig.localUrl}/books/${widget.slug}'),
        body: {
          'name': name,
          'author': author,
          'descriptions': descriptions,
        },
      );

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BooksList()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data Successfully Updated'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data Update Failed'),
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Book'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  controller: _nameController,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Author',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  controller: _authorController,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Descriptions',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  controller: _descriptionsController,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    updateBook();
                  },
                  child: const Text('Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
