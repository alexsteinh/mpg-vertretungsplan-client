// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'replacement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Replacement _$ReplacementFromJson(Map<String, dynamic> json) {
  return Replacement(
    json['date'] as String,
    json['period'] as String,
    json['newSubject'] as String,
    json['room'] as String,
    json['oldSubject'] as String,
    json['text'] as String,
  );
}

Map<String, dynamic> _$ReplacementToJson(Replacement instance) =>
    <String, dynamic>{
      'date': instance.date,
      'period': instance.period,
      'newSubject': instance.newSubject,
      'room': instance.room,
      'oldSubject': instance.oldSubject,
      'text': instance.text,
    };
