// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Grade _$GradeFromJson(Map<String, dynamic> json) {
  return Grade(
    json['name'] as String,
    json['code'] as int,
  );
}

Map<String, dynamic> _$GradeToJson(Grade instance) => <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
    };
