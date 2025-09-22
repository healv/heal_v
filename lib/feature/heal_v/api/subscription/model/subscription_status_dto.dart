import 'package:json_annotation/json_annotation.dart';

part 'subscription_status_dto.g.dart';

@JsonSerializable()
class SubscriptionStatusDto {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "stripeCustomerId")
  final String? stripeCustomerId;
  @JsonKey(name: "subscriptionId")
  final String? subscriptionId;
  @JsonKey(name: "productId")
  final String? productId;
  @JsonKey(name: "priceId")
  final String? priceId;
  @JsonKey(name: "planName")
  final String? planName;
  @JsonKey(name: "billingInterval")
  final String? billingInterval;
  @JsonKey(name: "subscriptionStartDate")
  final String? subscriptionStartDate;
  @JsonKey(name: "currentPeriodEnd")
  final String? currentPeriodEnd;
  @JsonKey(name: "cancelAtPeriodEnd")
  final bool? cancelAtPeriodEnd;

  SubscriptionStatusDto({
    required this.status,
    required this.stripeCustomerId,
    required this.subscriptionId,
    required this.productId,
    required this.priceId,
    required this.planName,
    required this.billingInterval,
    required this.subscriptionStartDate,
    required this.currentPeriodEnd,
    required this.cancelAtPeriodEnd,
  });

  factory SubscriptionStatusDto.fromJson(Map<String, dynamic> json) {
    return _$SubscriptionStatusDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SubscriptionStatusDtoToJson(this);
  }
}
