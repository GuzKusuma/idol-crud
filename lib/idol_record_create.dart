import 'dart:async';

import 'package:flutter/material.dart';
import 'package:books_crud/models/idol_record.dart';
import 'package:books_crud/my_idol_list_screen.dart';
import 'package:books_crud/services/api.dart';

class IdolRecordCreate extends StatefulWidget {
  const IdolRecordCreate({super.key});

  @override
  State<IdolRecordCreate> createState() {
    return _IdolRecordCreateState();
  }
}

class _IdolRecordCreateState extends State<IdolRecordCreate> {
  final TextEditingController _controller = TextEditingController();
  Future<IdolRecord>? _futureIdolRecord;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Idol',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Create Idol'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: (_futureIdolRecord == null)
              ? buildColumn()
              : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Enter Title'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureIdolRecord = API.createIdolRecord(_controller.text);
            });
          },
          child: const Text('Create Data'),
        ),
      ],
    );
  }

  FutureBuilder<IdolRecord> buildFutureBuilder() {
    return FutureBuilder<IdolRecord>(
      future: _futureIdolRecord,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          WidgetsBinding.instance.addPostFrameCallback((_) =>
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const MyIdolListScreen();
              })));
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
