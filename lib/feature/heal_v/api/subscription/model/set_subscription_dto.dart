import 'package:json_annotation/json_annotation.dart';

part 'set_subscription_dto.g.dart';

@JsonSerializable()
class SetSubscriptionDto {
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
  @JsonKey(name: "customerId")
  final String? customerId;
  @JsonKey(name: "customerEphemeralKeySecret")
  final String? customerEphemeralKeySecret;
  @JsonKey(name: "merchantCountryCode")
  final String? merchantCountryCode;

  SetSubscriptionDto({
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
    required this.customerId,
    required this.customerEphemeralKeySecret,
    required this.merchantCountryCode,
  });

  factory SetSubscriptionDto.fromJson(Map<String, dynamic> json) {
    return _$SetSubscriptionDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SetSubscriptionDtoToJson(this);
  }
}
