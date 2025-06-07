// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_quiz_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompleteQuizDto _$CompleteQuizDtoFromJson(Map<String, dynamic> json) =>
    CompleteQuizDto(
      date: json['date'] as String?,
      passed: json['passed'] as bool?,
      correctAnswers: (json['correctAnswers'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CompleteQuizDtoToJson(CompleteQuizDto instance) =>
    <String, dynamic>{
      'date': instance.date,
      'passed': instance.passed,
      'correctAnswers': instance.correctAnswers,
    };
