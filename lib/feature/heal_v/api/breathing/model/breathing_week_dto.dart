import 'package:json_annotation/json_annotation.dart';

part 'breathing_week_dto.g.dart';

@JsonSerializable()
class BreathingWeekDto {
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

  BreathingWeekDto({
    this.id,
    this.title,
    this.order,
    this.isAccessible,
    this.isCompleted,
  });

  factory BreathingWeekDto.fromJson(Map<String, dynamic> json) {
    return _$BreathingWeekDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BreathingWeekDtoToJson(this);
  }
}
