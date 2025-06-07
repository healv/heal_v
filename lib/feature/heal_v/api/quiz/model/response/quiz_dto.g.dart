// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizDto _$QuizDtoFromJson(Map<String, dynamic> json) => QuizDto(
      id: json['id'] as String?,
      title: json['title'] as String?,
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => QuizQuestionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuizDtoToJson(QuizDto instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'questions': instance.questions,
    };

QuizQuestionDto _$QuizQuestionDtoFromJson(Map<String, dynamic> json) =>
    QuizQuestionDto(
      id: json['id'] as String?,
      title: json['title'] as String?,
      answers: (json['answers'] as List<dynamic>?)
          ?.map(
              (e) => QuizQuestionAnswerDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuizQuestionDtoToJson(QuizQuestionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'answers': instance.answers,
    };

QuizQuestionAnswerDto _$QuizQuestionAnswerDtoFromJson(
        Map<String, dynamic> json) =>
    QuizQuestionAnswerDto(
      id: json['id'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$QuizQuestionAnswerDtoToJson(
        QuizQuestionAnswerDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
