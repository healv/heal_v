import 'package:json_annotation/json_annotation.dart';

part 'meditation_week_dto.g.dart';

@JsonSerializable()
class MeditationWeekDto {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "order")
  final int? order;
  @JsonKey(name: "isAccessible")
  final bool? isAccessible;
  @JsonKey(name: "isCompleted")
  final bool? isCompleted;

  MeditationWeekDto({
    this.id,
    this.title,
    this.order,
    this.isAccessible,
    this.isCompleted
  });

  factory MeditationWeekDto.fromJson(Map<String, dynamic> json) {
    return _$MeditationWeekDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MeditationWeekDtoToJson(this);
  }
}
