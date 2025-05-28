// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stretching_week_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StretchingWeekDto _$StretchingWeekDtoFromJson(Map<String, dynamic> json) =>
    StretchingWeekDto(
      id: json['id'] as String?,
      title: json['title'] as String?,
      order: (json['order'] as num?)?.toInt(),
      isAccessible: json['isAccessible'] as bool?,
      isCompleted: json['isCompleted'] as bool?,
    );

Map<String, dynamic> _$StretchingWeekDtoToJson(StretchingWeekDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'order': instance.order,
      'isAccessible': instance.isAccessible,
      'isCompleted': instance.isCompleted,
    };
