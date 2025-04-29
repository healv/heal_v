import 'package:json_annotation/json_annotation.dart';

part 'stretching_week_dto.g.dart';

@JsonSerializable()
class StretchingWeekDto {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "order")
  final int? order;

  StretchingWeekDto({
    this.id,
    this.title,
    this.order,
  });

  factory StretchingWeekDto.fromJson(Map<String, dynamic> json) {
    return _$StretchingWeekDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StretchingWeekDtoToJson(this);
  }
}
