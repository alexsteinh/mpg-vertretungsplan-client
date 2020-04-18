import 'package:flutter/material.dart';
import 'package:mpg_vertretungsplan_client/widget/table_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Vertretungsplan",
      color: Colors.blue,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Vertretungsplan"),
        ),
        body: TableWidget("8d"),
        backgroundColor: Colors.blue,
      )
    );
  }
}
