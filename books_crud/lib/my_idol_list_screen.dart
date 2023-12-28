import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:books_crud/idol_record_delete.dart';
import 'package:books_crud/idol_record_detail.dart';
import 'package:books_crud/idol_record_update.dart';
import 'package:books_crud/idol_record_create.dart';
import 'package:books_crud/models/Idol.dart';
import 'package:books_crud/services/api.dart';

class MyIdolListScreen extends StatefulWidget {
  const MyIdolListScreen({super.key});

  @override
  createState() => _MyIdolListScreenState();
}

class _MyIdolListScreenState extends State {
  var idols = <Idol>[];

  _getIdols() {
    API.getIdols().then((response) {
      setState(() {
        Iterable list = json.decode(response.body)['data'];
        idols = list.map((model) => Idol.fromJson(model)).toList();
      });
    });
  }

  @override
  initState() {
    super.initState();
    _getIdols();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void navigate(context, data) {}

  @override
  build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Idols"),
        automaticallyImplyLeading: false,
      ),
      body: Scrollbar(
        child: ListView.builder(
          itemCount: idols.length,
          itemBuilder: (context, index) {
            return ListTile(
              trailing: Wrap(
                spacing: 12, // space between two icons
                children: [
                  GestureDetector(
                      child: const Icon(Icons.edit),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                IdolRecordUpdate(id: idols[index].id),
                          ),
                        );
                      }),
                  GestureDetector(
                      child: const Icon(Icons.delete),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                IdolRecordDelete(idol: idols[index]),
                          ),
                        );
                      }),
                ],
              ),
              title: Text(idols[index].name),
              subtitle: Text(idols[index].position),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IdolRecordDetail(idol: idols[index]),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Text("+", style: TextStyle(fontSize: 30)),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const IdolRecordCreate(),
                ));
          }),
    );
  }
}
