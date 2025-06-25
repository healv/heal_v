import 'package:json_annotation/json_annotation.dart';

part 'daily_progress_dto.g.dart';

@JsonSerializable()
class DailyProgressDto {
  @JsonKey(name: "date")
  final String? date;
  @JsonKey(name: "meditation")
  final bool? meditation;
  @JsonKey(name: "breathing")
  final bool? breathing;
  @JsonKey(name: "stretching")
  final bool? stretching;
  @JsonKey(name: "quiz")
  final DailyProgressQuizDto? quiz;
  @JsonKey(name: "journal")
  final String? journal;
  @JsonKey(name: "completed")
  final bool? completed;

  DailyProgressDto({
    this.date,
    this.meditation,
    this.breathing,
    this.stretching,
    this.quiz,
    this.journal,
    this.completed,
  });

  factory DailyProgressDto.fromJson(Map<String, dynamic> json) {
    return _$DailyProgressDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DailyProgressDtoToJson(this);
  }
}

@JsonSerializable()
class DailyProgressQuizDto {
  @JsonKey(name: "completed")
  final bool? completed;
  @JsonKey(name: "passed")
  final bool? passed;

  DailyProgressQuizDto({
    this.completed,
    this.passed,
  });

  factory DailyProgressQuizDto.fromJson(Map<String, dynamic> json) {
    return _$DailyProgressQuizDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DailyProgressQuizDtoToJson(this);
  }
}
