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
      quiz: json['quiz'] == null
          ? null
          : DailyProgressQuizDto.fromJson(json['quiz'] as Map<String, dynamic>),
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

DailyProgressQuizDto _$DailyProgressQuizDtoFromJson(
        Map<String, dynamic> json) =>
    DailyProgressQuizDto(
      completed: json['completed'] as bool?,
      passed: json['passed'] as bool?,
    );

Map<String, dynamic> _$DailyProgressQuizDtoToJson(
        DailyProgressQuizDto instance) =>
    <String, dynamic>{
      'completed': instance.completed,
      'passed': instance.passed,
    };
