// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Table _$TableFromJson(Map<String, dynamic> json) {
  return Table(
    json['grade'] == null
        ? null
        : Grade.fromJson(json['grade'] as Map<String, dynamic>),
    (json['replacements'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k,
          (e as List)
              ?.map((e) => e == null
                  ? null
                  : Replacement.fromJson(e as Map<String, dynamic>))
              ?.toList()),
    ),
    (json['messages'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k,
          (e as List)
              ?.map((e) => e == null
                  ? null
                  : Message.fromJson(e as Map<String, dynamic>))
              ?.toList()),
    ),
  );
}

Map<String, dynamic> _$TableToJson(Table instance) => <String, dynamic>{
      'grade': instance.grade?.toJson(),
      'replacements': instance.replacements
          ?.map((k, e) => MapEntry(k, e?.map((e) => e?.toJson())?.toList())),
      'messages': instance.messages
          ?.map((k, e) => MapEntry(k, e?.map((e) => e?.toJson())?.toList())),
    };
