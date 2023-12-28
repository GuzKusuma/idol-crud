import 'package:books_crud/books_crud/books_detail.dart';
import 'package:flutter/material.dart';
import 'package:books_crud/model/library_Books.dart';
import 'package:books_crud/services/library_api.dart';
import 'package:books_crud/books_crud/books_create.dart';
import 'package:books_crud/books_update.dart';

class BooksList extends StatefulWidget {
  const BooksList({Key? key});

  @override
  State<BooksList> createState() => _BooksListState();
}

class _BooksListState extends State<BooksList> {
  List<Books> listBooks = [];
  LibraryApi libraryApi = LibraryApi();

  Future<void> getBooks() async {
    listBooks = await libraryApi.getBooks();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getBooks();
  }

  Future<void> deleteBook(int index) async {
    bool response = await libraryApi.deleteBooks(
      listBooks[index].slug,
    );

    if (response) {
      getBooks();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data Deleted Successfully'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data Deletion Failed'),
        ),
      );
    }
  }

  void showDeleteConfirmation(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Book Data'),
          content:
              const Text('Are you sure you want to delete this book data?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                deleteBook(index);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Books List'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BooksCreate()),
                );
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: listBooks.isEmpty
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                ),
              )
            : ListView.builder(
                itemCount: listBooks.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 5,
                    ),
                    child: Card(
                      elevation: 5,
                      shadowColor: Colors.grey.withOpacity(0.5),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  BooksDetail(book: listBooks[index]),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: Container(
                            height: 100,
                            width: 75,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.pink,
                            ),
                            child: Icon(
                              Icons.book,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            listBooks[index].name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BooksUpdate(
                                        slug: listBooks[index].slug,
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.book),
                              ),
                              IconButton(
                                onPressed: () {
                                  showDeleteConfirmation(context, index);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
