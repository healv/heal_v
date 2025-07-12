import 'package:json_annotation/json_annotation.dart';

part 'create_subscription_dto.g.dart';

@JsonSerializable()
class CreateSubscriptionDto {
  @JsonKey(name: "subscriptionId")
  final String? subscriptionId;
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "clientSecret")
  final String? clientSecret;
  @JsonKey(name: "debug")
  final CreateSubscriptionDebugDto? debug;

  CreateSubscriptionDto({
    required this.subscriptionId,
    required this.status,
    required this.message,
    required this.clientSecret,
    required this.debug,
  });

  factory CreateSubscriptionDto.fromJson(Map<String, dynamic> json) {
    return _$CreateSubscriptionDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CreateSubscriptionDtoToJson(this);
  }
}

@JsonSerializable()
class CreateSubscriptionDebugDto {
  @JsonKey(name: "hasClientSecret")
  final bool? hasClientSecret;
  @JsonKey(name: "customerId")
  final String? customerId;
  @JsonKey(name: "subscriptionStatus")
  final String? subscriptionStatus;

  CreateSubscriptionDebugDto({
    required this.hasClientSecret,
    required this.customerId,
    required this.subscriptionStatus,
  });

  factory CreateSubscriptionDebugDto.fromJson(Map<String, dynamic> json) {
    return _$CreateSubscriptionDebugDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CreateSubscriptionDebugDtoToJson(this);
  }
}
