import 'package:json_annotation/json_annotation.dart';

part 'complete_quiz_request.g.dart';

@JsonSerializable()
class CompleteQuizRequest {
  @JsonKey(name: "answers")
  final Map<String, String>? answers;

  CompleteQuizRequest({
    this.answers,
  });

  factory CompleteQuizRequest.fromJson(Map<String, dynamic> json) {
    return _$CompleteQuizRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CompleteQuizRequestToJson(this);
  }
}
