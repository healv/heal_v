import 'package:json_annotation/json_annotation.dart';

part 'complete_quiz_dto.g.dart';

@JsonSerializable()
class CompleteQuizDto {
  @JsonKey(name: "date")
  final String? date;
  @JsonKey(name: "passed")
  final bool? passed;
  @JsonKey(name: "correctAnswers")
  final int? correctAnswers;

  CompleteQuizDto({
    this.date,
    this.passed,
    this.correctAnswers,
  });

  factory CompleteQuizDto.fromJson(Map<String, dynamic> json) {
    return _$CompleteQuizDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CompleteQuizDtoToJson(this);
  }
}
