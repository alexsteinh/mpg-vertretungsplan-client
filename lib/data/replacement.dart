import 'package:json_annotation/json_annotation.dart';

part 'replacement.g.dart';

@JsonSerializable(explicitToJson: true)
class Replacement {
  final String date, period, newSubject, room, oldSubject, text;

  Replacement(this.date, this.period, this.newSubject, this.room,
    this.oldSubject, this.text);

  factory Replacement.fromJson(Map<String, dynamic> json) => _$ReplacementFromJson(json);

  Map<String, dynamic> toJson() => _$ReplacementToJson(this);
}