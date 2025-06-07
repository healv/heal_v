import 'package:json_annotation/json_annotation.dart';

part 'total_progress_dto.g.dart';

@JsonSerializable()
class TotalProgressDto {
  @JsonKey(name: "meditation")
  final int? meditation;
  @JsonKey(name: "stretching")
  final int? stretching;
  @JsonKey(name: "breathing")
  final int? breathing;

  TotalProgressDto({
    this.meditation,
    this.stretching,
    this.breathing,
  });

  factory TotalProgressDto.fromJson(Map<String, dynamic> json) {
    return _$TotalProgressDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TotalProgressDtoToJson(this);
  }
}
