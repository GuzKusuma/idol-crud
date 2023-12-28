import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:books_crud/helper/connection_config.dart';

import 'package:books_crud/models/idol_record.dart';

const baseUrl = "jsonplaceholder.typicode.com";
const localUrl = ConnectionConfig.localUrl;

class API {
  static Future getUsers() {
    final url = Uri.https(baseUrl, "/users");
    return http.get(url);
  }

  static Future getIdols() {
    final url = Uri.http(localUrl, "/show-index");
    return http.get(url);
  }

  static Future<IdolRecord> createIdolRecord(String title) async {
    final response = await http.post(
      Uri.http(localUrl, "/create-data"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return IdolRecord.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create IdolRecord.');
    }
  }

  static Future<http.Response> deleteIdolRecord(String id) async {
    final http.Response response = await http.delete(
      Uri.http(localUrl, "/delete-data/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;

    // if (response.statusCode == 200) {
    //   // If the server did return a 201 CREATED response,
    //   // then parse the JSON.
    //   return Book.fromJson(jsonDecode(response.body));
    // } else {
    //   // If the server did not return a 201 CREATED response,
    //   // then throw an exception.
    //   throw Exception('Failed to create BookRecord.');
    // }
  }
}
