import 'package:json_annotation/json_annotation.dart';

part 'tree_growth_dto.g.dart';

@JsonSerializable()
class TreeGrowthDto {
  @JsonKey(name: "progress")
  final int? progress;
  @JsonKey(name: "idealDayCount")
  final int? idealDayCount;
  @JsonKey(name: "phase")
  final int? phase;
  @JsonKey(name: "dates")
  final List<String>? dates;
  @JsonKey(name: "datesCount")
  final int? datesCount;
  @JsonKey(name: "idealDays")
  final List<String>? idealDays;
  @JsonKey(name: "idealDaysCount")
  final int? idealDaysCount;
  @JsonKey(name: "missedDays")
  final List<String>? missedDays;
  @JsonKey(name: "missedDaysCount")
  final int? missedDaysCount;

  TreeGrowthDto({
    this.progress,
    this.idealDayCount,
    this.phase,
    this.dates,
    this.datesCount,
    this.idealDays,
    this.idealDaysCount,
    this.missedDays,
    this.missedDaysCount,
  });

  factory TreeGrowthDto.fromJson(Map<String, dynamic> json) {
    return _$TreeGrowthDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TreeGrowthDtoToJson(this);
  }
}
