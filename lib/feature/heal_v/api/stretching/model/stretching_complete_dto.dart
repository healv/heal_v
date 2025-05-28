import 'package:json_annotation/json_annotation.dart';

part 'stretching_complete_dto.g.dart';

@JsonSerializable()
class StretchingCompleteDto {
  @JsonKey(name: "success")
  final bool? success;

  StretchingCompleteDto({
    this.success,
  });

  factory StretchingCompleteDto.fromJson(Map<String, dynamic> json) {
    return _$StretchingCompleteDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StretchingCompleteDtoToJson(this);
  }
}
