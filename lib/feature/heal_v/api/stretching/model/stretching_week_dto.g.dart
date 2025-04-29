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
    );

Map<String, dynamic> _$StretchingWeekDtoToJson(StretchingWeekDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'order': instance.order,
    };
