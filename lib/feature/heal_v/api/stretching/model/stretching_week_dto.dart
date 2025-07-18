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
  @JsonKey(name: "isAccessible")
  final bool? isAccessible;
  @JsonKey(name: "isCompleted")
  final bool? isCompleted;
  @JsonKey(name: "hasSubscriptionAccess")
  final bool? hasSubscriptionAccess;
  @JsonKey(name: "requiresSubscription")
  final bool? requiresSubscription;

  StretchingWeekDto({
    this.id,
    this.title,
    this.order,
    this.isAccessible,
    this.isCompleted,
    this.hasSubscriptionAccess,
    this.requiresSubscription,
  });

  factory StretchingWeekDto.fromJson(Map<String, dynamic> json) {
    return _$StretchingWeekDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StretchingWeekDtoToJson(this);
  }
}
