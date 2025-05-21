import 'package:json_annotation/json_annotation.dart';

part 'meditation_complete_dto.g.dart';

@JsonSerializable()
class MeditationCompleteDto {
  @JsonKey(name: "success")
  final bool? success;

  MeditationCompleteDto({
    this.success,
  });

  factory MeditationCompleteDto.fromJson(Map<String, dynamic> json) {
    return _$MeditationCompleteDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MeditationCompleteDtoToJson(this);
  }
}
