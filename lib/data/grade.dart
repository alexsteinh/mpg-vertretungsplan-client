import 'package:json_annotation/json_annotation.dart';

part 'grade.g.dart';

@JsonSerializable(explicitToJson: true)
class Grade {
  final String name;
  final int code;

  Grade(this.name, this.code);

  factory Grade.fromJson(Map<String, dynamic> json) => _$GradeFromJson(json);

  Map<String, dynamic> toJson() => _$GradeToJson(this);
}