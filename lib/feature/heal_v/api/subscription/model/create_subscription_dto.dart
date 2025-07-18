import 'package:json_annotation/json_annotation.dart';

part 'create_subscription_dto.g.dart';

@JsonSerializable()
class CreateSubscriptionDto {
  @JsonKey(name: "success")
  final bool? success;
  @JsonKey(name: "subscriptionId")
  final String? subscriptionId;
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "productId")
  final String? productId;
  @JsonKey(name: "planName")
  final String? planName;
  @JsonKey(name: "billingInterval")
  final String? billingInterval;
  @JsonKey(name: "amount")
  final int? amount;
  @JsonKey(name: "currency")
  final String? currency;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "trialEnd")
  final String? trialEnd;
  @JsonKey(name: "clientSecret")
  final String? clientSecret;
  @JsonKey(name: "requiresPayment")
  final bool? requiresPayment;

  CreateSubscriptionDto({
    required this.success,
    required this.subscriptionId,
    required this.status,
    required this.productId,
    required this.planName,
    required this.billingInterval,
    required this.amount,
    required this.currency,
    required this.message,
    required this.trialEnd,
    required this.clientSecret,
    required this.requiresPayment,
  });

  factory CreateSubscriptionDto.fromJson(Map<String, dynamic> json) {
    return _$CreateSubscriptionDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CreateSubscriptionDtoToJson(this);
  }
}
