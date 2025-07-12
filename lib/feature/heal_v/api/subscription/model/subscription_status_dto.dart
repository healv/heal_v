import 'package:json_annotation/json_annotation.dart';

part 'subscription_status_dto.g.dart';

@JsonSerializable()
class SubscriptionStatusDto {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "isFull")
  final bool? isFull;
  @JsonKey(name: "currentPeriodEnd")
  final int? currentPeriodEnd;
  @JsonKey(name: "currentPeriodStart")
  final int? currentPeriodStart;
  @JsonKey(name: "cancelAtPeriodEnd")
  final bool? cancelAtPeriodEnd;
  @JsonKey(name: "canceledAt")
  final int? canceledAt;
  @JsonKey(name: "subscriptionId")
  final String? subscriptionId;

  SubscriptionStatusDto({
    required this.status,
    required this.isFull,
    required this.currentPeriodEnd,
    required this.currentPeriodStart,
    required this.cancelAtPeriodEnd,
    required this.canceledAt,
    required this.subscriptionId,
  });

  factory SubscriptionStatusDto.fromJson(Map<String, dynamic> json) {
    return _$SubscriptionStatusDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SubscriptionStatusDtoToJson(this);
  }
}
