// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_quiz_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompleteQuizRequest _$CompleteQuizRequestFromJson(Map<String, dynamic> json) =>
    CompleteQuizRequest(
      answers: (json['answers'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$CompleteQuizRequestToJson(
        CompleteQuizRequest instance) =>
    <String, dynamic>{
      'answers': instance.answers,
    };
