// import 'package:books_crud/models/book.dart';
// import 'package:books_crud/services/book_api.dart';
// import 'package:flutter/material.dart';
// import 'dart:convert';

// import 'create_book.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   var books = <Book>[];

//   _getData() {
//     BookApi.getBooks().then((res) {
//       setState(() {
//         Iterable list = json.decode(res.body)[''];

//         books = list.map((e) => Book.fromJson(e)).toList();
//       });
//     });
//   }

//   @override
//   void initState() {
//     _getData();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Book List'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: ListView.builder(
//           itemCount: books.length,
//           itemBuilder: (context, index) {
//             return ListTile(
//               title: Text(books[index].name),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("author: ${books[index].author}"),
//                   Text("Description: ${books[index].description}"),
//                 ],
//               ),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TextButton(
//                     onPressed: () {
//                       BookApi.deleteBook(books[index].id);
//                       setState(() {
//                         _getData();
//                       });
//                     },
//                     child: const Text(
//                       "Hapus",
//                       style: TextStyle(color: Colors.red),
//                     ),
//                   ),
//                   TextButton(
//                       onPressed: () {
//                         Navigator.of(context).popAndPushNamed(
//                           "/update-data",
//                           arguments: [
//                             books[index].id,
//                             books[index].name,
//                             books[index].author,
//                             books[index].description,
//                           ],
//                         );
//                       },
//                       child: const Text("Edit")),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//       floatingActionButton: ElevatedButton(
//           onPressed: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const CreateBook(),
//                 ));
//           },
//           child: const Text("Tambah ")),
//     );
//   }
// }
