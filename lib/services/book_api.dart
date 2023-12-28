// import 'package:http/http.dart' as http;
// import 'dart:async';

// const baseUrl = "192.168.1.198:8000";

// class BookApi {
//   static Future getBooks() async {
//     final url = Uri.http(baseUrl, "/books");
//     return http.get(url);
//   }

//   static Future createBook(String Judul, String Deskripsi) {
//     final url = Uri.http(baseUrl, "/books");
//     return http.post(url, body: {'judul': Judul, 'description': Deskripsi});
//   }

//   static Future updateBook(
//       int id, String title, String description, String text) {
//     final url = Uri.http(baseUrl, "/books/${id}");
//     return http.put(url, body: {'title': title, 'description': description});
//   }

//   static Future deleteBook(int id) {
//     final url = Uri.http(baseUrl, "/books/${id}");
//     return http.delete(url);
//   }
// }
