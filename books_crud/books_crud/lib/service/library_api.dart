import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'books_crud/model/Books.dart'; // Ubah 'path_ke_models' sesuai dengan jalur ke file Books.dart

class LibraryApi {
  final localUrl = 'http://192.168.236.118:8000';
  // static const baseUrl = "jsonplaceholder.typicode.com";

  Future<List<Books>> getBooks() async {
    try {
      final response = await http.get(Uri.parse('$localUrl/books'));

      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<Books> books = it.map((e) => Books.fromJson(e)).toList();
        return books;
      }
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  Future<bool> deleteBooks(String slug) async {
    try {
      final response = await http.delete(Uri.parse('$localUrl/books/$slug'));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  Future<bool> createBooks(
      String name, String slug, String author, String descriptions) async {
    try {
      final response = await http.post(Uri.parse('$localUrl/books'), body: {
        'name': name,
        'slug': slug,
        'author': author,
        'des
