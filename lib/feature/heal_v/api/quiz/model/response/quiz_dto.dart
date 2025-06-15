import 'package:json_annotation/json_annotation.dart';

part 'quiz_dto.g.dart';

@JsonSerializable()
class QuizDto {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "questions")
  final List<QuizQuestionDto>? questions;

  QuizDto({
    this.id,
    this.title,
    this.questions,
  });

  factory QuizDto.fromJson(Map<String, dynamic> json) {
    return _$QuizDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$QuizDtoToJson(this);
  }
}

@JsonSerializable()
class QuizQuestionDto {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "answers")
  final List<QuizQuestionAnswerDto>? answers;

  QuizQuestionDto({
    this.id,
    this.title,
    this.answers,
  });

  factory QuizQuestionDto.fromJson(Map<String, dynamic> json) {
    return _$QuizQuestionDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$QuizQuestionDtoToJson(this);
  }
}

@JsonSerializable()
class QuizQuestionAnswerDto {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "title")
  final String? title;

  QuizQuestionAnswerDto({
    this.id,
    this.title,
  });

  factory QuizQuestionAnswerDto.fromJson(Map<String, dynamic> json) {
    return _$QuizQuestionAnswerDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$QuizQuestionAnswerDtoToJson(this);
  }
}
