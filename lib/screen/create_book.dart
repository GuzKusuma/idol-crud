// import 'package:books_crud/screen/home.dart';
// import 'package:books_crud/services/book_api.dart';
// import 'package:flutter/material.dart';

// class CreateBook extends StatefulWidget {
//   const CreateBook({super.key});

//   @override
//   State<CreateBook> createState() => _CreateBookState();
// }

// class _CreateBookState extends State<CreateBook> {
//   final TextEditingController _titleController = TextEditingController();

//   final TextEditingController _descriptionController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Add Book"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _titleController,
//               decoration: const InputDecoration(
//                 label: Text('Title'),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             TextField(
//               controller: _descriptionController,
//               decoration: const InputDecoration(
//                 label: Text('Description'),
//               ),
//             ),
//             TextButton(
//                 onPressed: () {
//                   BookApi.createBook(
//                       _titleController.text, _descriptionController.text);
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => Home(),
//                       ));
//                 },
//                 child: Text("simpan")),
//           ],
//         ),
//       ),
//     );
//   }
// }
