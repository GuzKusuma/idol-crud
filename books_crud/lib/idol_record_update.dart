import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:books_crud/helper/connection_config.dart';
import 'package:books_crud/my_idol_list_screen.dart';

Future<IdolUpdate> fetchIdolUpdate(int id) async {
  final response = await http.get(
    Uri.http(ConnectionConfig.localUrl, "/get-data-id/$id"),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return IdolUpdate.fromJson(jsonDecode(response.body)['data']);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load IdolUpdate');
  }
}

Future<IdolUpdate> updateIdolUpdate(String name, int id) async {
  final response = await http.put(
    Uri.http(ConnectionConfig.localUrl, "/update-data/$id"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'name': name}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return IdolUpdate.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to update IdolUpdate.');
  }
}

class IdolUpdate {
  final int id;
  final String name;

  const IdolUpdate({required this.id, required this.name});

  factory IdolUpdate.fromJson(Map<String, dynamic> json) {
    return IdolUpdate(
      id: json['id'],
      name: json['name'],
    );
  }
}

// void main() {
//   runApp(const IdolRecordUpdate());
// }

class IdolRecordUpdate extends StatefulWidget {
  final int id;
  const IdolRecordUpdate({super.key, required this.id});

  @override
  State<IdolRecordUpdate> createState() {
    return _IdolRecordUpdateState();
  }
}

class _IdolRecordUpdateState extends State<IdolRecordUpdate> {
  final TextEditingController _controller = TextEditingController();
  late Future<IdolUpdate> _futureIdolUpdate;
  late int _id;

  @override
  void initState() {
    super.initState();
    _futureIdolUpdate = fetchIdolUpdate(widget.id);
    _id = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Update Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Update Data Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: FutureBuilder<IdolUpdate>(
            future: _futureIdolUpdate,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  _controller.text = snapshot.data!.name;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Update Idol Name"),
                      TextField(
                        controller: _controller,
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: 'Enter Title',
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _futureIdolUpdate =
                                updateIdolUpdate(_controller.text, _id);
                            WidgetsBinding.instance.addPostFrameCallback((_) =>
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const MyIdolListScreen();
                                })));
                          });
                        },
                        child: const Text('Update Data'),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
              }

              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
