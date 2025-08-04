import 'package:json_annotation/json_annotation.dart';

part 'subscription_dto.g.dart';

@JsonSerializable()
class SubscriptionDto {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "cancelAtPeriodEnd")
  final bool? cancelAtPeriodEnd;
  @JsonKey(name: "currentPeriodEnd")
  final bool? currentPeriodEnd;

  SubscriptionDto({
    required this.id,
    required this.status,
    required this.cancelAtPeriodEnd,
    required this.currentPeriodEnd,
  });

  factory SubscriptionDto.fromJson(Map<String, dynamic> json) {
    return _$SubscriptionDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SubscriptionDtoToJson(this);
  }
}
