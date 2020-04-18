import 'package:json_annotation/json_annotation.dart';
import 'package:mpg_vertretungsplan_client/data/grade.dart';
import 'package:mpg_vertretungsplan_client/data/message.dart';
import 'package:mpg_vertretungsplan_client/data/replacement.dart';

part 'table.g.dart';

@JsonSerializable(explicitToJson: true)
class Table {
  final Grade grade;
  final Map<String, List<Replacement>> replacements;
  final Map<String, List<Message>> messages;

  Table(this.grade, this.replacements, this.messages);

  factory Table.fromJson(Map<String, dynamic> json) => _$TableFromJson(json);

  Map<String, dynamic> toJson() => _$TableToJson(this);
}