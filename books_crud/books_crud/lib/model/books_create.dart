import 'package:books_crud/model/library_Books.dart';
import 'package:books_crud/service/library_api.dart';
import 'package:flutter/material.dart';
import 'package:books_crud/books_crud/books_list.dart';

class BooksCreate extends StatefulWidget {
  const BooksCreate({Key? key});

  @override
  State<BooksCreate> createState() => _BooksCreateState();
}

class _BooksCreateState extends State<BooksCreate> {
  LibraryApi libraryApi = LibraryApi();
  List<Books> listBooks = [];
  final _nameController = TextEditingController();
  final _slugController = TextEditingController();
  final _authorController = TextEditingController();
  final _descriptionsController = TextEditingController();

  Future<void> getBooks() async {
    listBooks = await libraryApi.getBooks();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getBooks();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _slugController.dispose();
    _authorController.dispose();
    _descriptionsController.dispose();
    super.dispose();
  }

  Future<void> createBooks() async {
    try {
      final response = await libraryApi.createBooks(
        _nameController.text,
        _slugController.text,
        _authorController.text,
        _descriptionsController.text,
      );

      if (response != null) {
        getBooks();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => BooksList()));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data Saved Successfully'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data Failed to Save'),
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void showSaveConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Save Book Record'),
          content: const Text('Are you sure you want to save this book data?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                createBooks();
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Books'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                  labelText: 'Slug',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                controller: _slugController,
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
                  showSaveConfirmation(context);
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
