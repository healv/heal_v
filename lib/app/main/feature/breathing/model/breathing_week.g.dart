// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breathing_week.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BreathingWeek _$BreathingWeekFromJson(Map<String, dynamic> json) =>
    BreathingWeek(
      id: json['id'] as String?,
      title: json['title'] as String?,
      order: (json['order'] as num?)?.toInt(),
      isAccessible: json['isAccessible'] as bool?,
      isCompleted: json['isCompleted'] as bool?,
    );

Map<String, dynamic> _$BreathingWeekToJson(BreathingWeek instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'order': instance.order,
      'isAccessible': instance.isAccessible,
      'isCompleted': instance.isCompleted,
    };
