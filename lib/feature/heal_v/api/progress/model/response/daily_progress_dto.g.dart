// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_progress_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyProgressDto _$DailyProgressDtoFromJson(Map<String, dynamic> json) =>
    DailyProgressDto(
      meditation: json['meditation'] as bool?,
      breathing: json['breathing'] as bool?,
      stretching: json['stretching'] as bool?,
      journal: json['journal'] as bool?,
      completed: json['completed'] as bool?,
      lastUpdated: json['lastUpdated'] as String?,
    );

Map<String, dynamic> _$DailyProgressDtoToJson(DailyProgressDto instance) =>
    <String, dynamic>{
      'meditation': instance.meditation,
      'breathing': instance.breathing,
      'stretching': instance.stretching,
      'journal': instance.journal,
      'completed': instance.completed,
      'lastUpdated': instance.lastUpdated,
    };
