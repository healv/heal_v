import 'package:json_annotation/json_annotation.dart';

part 'cancel_subscription_dto.g.dart';

@JsonSerializable()
class CancelSubscriptionDto {
  @JsonKey(name: "success")
  final bool? success;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "cancelAtPeriodEnd")
  final bool? cancelAtPeriodEnd;
  @JsonKey(name: "currentPeriodEnd")
  final int? currentPeriodEnd;
  @JsonKey(name: "status")
  final String? status;

  CancelSubscriptionDto({
    required this.success,
    required this.message,
    required this.cancelAtPeriodEnd,
    required this.currentPeriodEnd,
    required this.status,
  });

  factory CancelSubscriptionDto.fromJson(Map<String, dynamic> json) {
    return _$CancelSubscriptionDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CancelSubscriptionDtoToJson(this);
  }
}
