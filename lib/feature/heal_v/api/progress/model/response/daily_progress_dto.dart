import 'package:json_annotation/json_annotation.dart';

part 'daily_progress_dto.g.dart';

@JsonSerializable()
class DailyProgressDto {
  @JsonKey(name: "meditation")
  final bool? meditation;
  @JsonKey(name: "breathing")
  final bool? breathing;
  @JsonKey(name: "stretching")
  final bool? stretching;
  @JsonKey(name: "journal")
  final bool? journal;
  @JsonKey(name: "completed")
  final bool? completed;
  @JsonKey(name: "lastUpdated")
  final String? lastUpdated;

  DailyProgressDto({
    this.meditation,
    this.breathing,
    this.stretching,
    this.journal,
    this.completed,
    this.lastUpdated,
  });

  factory DailyProgressDto.fromJson(Map<String, dynamic> json) {
    return _$DailyProgressDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DailyProgressDtoToJson(this);
  }
}
