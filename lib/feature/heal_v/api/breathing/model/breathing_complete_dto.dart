import 'package:json_annotation/json_annotation.dart';

part 'breathing_complete_dto.g.dart';

@JsonSerializable()
class BreathingCompleteDto {
  @JsonKey(name: "success")
  final bool? success;

  BreathingCompleteDto({
    this.success,
  });

  factory BreathingCompleteDto.fromJson(Map<String, dynamic> json) {
    return _$BreathingCompleteDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BreathingCompleteDtoToJson(this);
  }
}
