// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meditation_week.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeditationWeek _$MeditationWeekFromJson(Map<String, dynamic> json) =>
    MeditationWeek(
      id: json['id'] as String?,
      title: json['title'] as String?,
      order: (json['order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MeditationWeekToJson(MeditationWeek instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'order': instance.order,
    };
