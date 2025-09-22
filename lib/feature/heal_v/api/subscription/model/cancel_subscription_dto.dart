import 'package:heal_v/feature/heal_v/api/subscription/model/subscription_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cancel_subscription_dto.g.dart';

@JsonSerializable()
class CancelSubscriptionDto {
  @JsonKey(name: "success")
  final bool? success;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "subscription")
  final SubscriptionDto? subscription;

  CancelSubscriptionDto({
    required this.success,
    required this.message,
    required this.subscription,
  });

  factory CancelSubscriptionDto.fromJson(Map<String, dynamic> json) {
    return _$CancelSubscriptionDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CancelSubscriptionDtoToJson(this);
  }
}
