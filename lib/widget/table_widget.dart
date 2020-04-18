import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mpg_vertretungsplan_client/data/message.dart';
import 'package:mpg_vertretungsplan_client/data/replacement.dart';
import 'package:mpg_vertretungsplan_client/data/table.dart' as vp;

class TableWidget extends StatefulWidget {
  final String _grade;

  TableWidget(this._grade);

  _TableWidgetState createState() => _TableWidgetState(_grade);
}

class _TableWidgetState extends State<TableWidget> {
  String _json = "";
  final String _grade ;
  bool _loaded = false;

  _TableWidgetState(this._grade);

  @override
  void initState() {
    super.initState();
    _downloadText();
  }

  void _downloadText() {
    var path = "https://v2201910106428100529.supersrv.de:8443/api/tables/" + _grade;
    var request = http.Request("GET", Uri.parse(path));
    request.encoding = Encoding.getByName("utf-8");
    var client = http.Client();
    try {
      client.send(request).then((response) {
        Future.delayed(Duration(seconds: 1), () {
          response.stream.bytesToString().then((json) {
            setState(() {
              _json = json;
              _loaded = true;
            });
          });
        });
      });
    } finally {
      client.close();
    }
  }

  Widget _buildProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  TableRow _fromReplacement(Replacement replacement) {
    return TableRow(
      children: [
        Text(replacement.period, textAlign: TextAlign.center,),
        Text(replacement.newSubject, textAlign: TextAlign.center,),
        Text(replacement.room, textAlign: TextAlign.center,),
        Text(replacement.oldSubject, textAlign: TextAlign.center,),
        Text(replacement.text, textAlign: TextAlign.center,),
      ]
    );
  }

  Widget _buildTable() {
    var data = jsonDecode(_json);
    var table = vp.Table.fromJson(data);

    var widgets = List<Widget>();

    for (String date in _extractAllDates(table)) {
      var children = List<Widget>()
        ..add(_DateWidget(date))
        ..add(Divider());
      var messages = table.messages[date];
      var replacements = table.replacements[date];
      if (messages != null) {
        children.addAll(messages.map((message) => _MessageWidget(message))); 
      }

      if (replacements != null) {
        children
          ..add(Divider())
          ..add(
            Table(
              defaultColumnWidth: FractionColumnWidth(0.2),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder.all(
                style: BorderStyle.solid,
                color: Colors.grey,
              ),
              children: replacements.map((replacement) => _fromReplacement(replacement)).toList()
                ..insert(0, TableRow(
                  children: [
                    Text("Stunde", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("Fach", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("Raum", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("Statt Fach", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("Text", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
                  ]
                ))
            )
          );
      }

      widgets.add(
        Card(
          margin: EdgeInsets.symmetric(vertical: 4),
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: children,
            ),
          ),
        )
      );
    }

    return ListView(
      children: widgets,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    );
  }

  List<String> _extractAllDates(vp.Table table) {
    var dates = Set<String>();
    dates.addAll(table.replacements.keys);
    dates.addAll(table.messages.keys);
    return dates.toList()..sort();
  }

  @override
  Widget build(BuildContext context) {
    return _loaded ? _buildTable() : _buildProgressIndicator();
  }
}

class _ReplacementWidget extends TableRow {
  final Replacement _replacement;

  _ReplacementWidget(this._replacement);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(_replacement.period),
        Text(_replacement.newSubject),
        Text(_replacement.room),
        Text(_replacement.oldSubject),
        Text(_replacement.text),
      ],
    );
  }
}

class _MessageWidget extends StatelessWidget {
  final Message _message;

  _MessageWidget(this._message);

  @override
  Widget build(BuildContext context) {
    return Text(
      _message.text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontStyle: FontStyle.italic,
      ),
    );
  }
}

class _DateWidget extends StatelessWidget {
  DateTime _date;
  
  _DateWidget(String date) {
    _date = DateTime.parse(date);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        _getWeekdayName(_date.weekday),
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  String _getWeekdayName(int index) {
    return ["Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "Sonntag"][index - 1];
  }
}
