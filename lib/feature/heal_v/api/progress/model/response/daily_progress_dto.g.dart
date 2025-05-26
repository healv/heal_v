// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_progress_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyProgressDto _$DailyProgressDtoFromJson(Map<String, dynamic> json) =>
    DailyProgressDto(
      date: json['date'] as String?,
      meditation: json['meditation'] as bool?,
      breathing: json['breathing'] as bool?,
      stretching: json['stretching'] as bool?,
      quiz: json['quiz'] as bool?,
      journal: json['journal'] as String?,
      completed: json['completed'] as bool?,
    );

Map<String, dynamic> _$DailyProgressDtoToJson(DailyProgressDto instance) =>
    <String, dynamic>{
      'date': instance.date,
      'meditation': instance.meditation,
      'breathing': instance.breathing,
      'stretching': instance.stretching,
      'quiz': instance.quiz,
      'journal': instance.journal,
      'completed': instance.completed,
    };
