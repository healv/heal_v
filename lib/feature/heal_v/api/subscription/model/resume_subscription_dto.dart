import 'package:json_annotation/json_annotation.dart';

part 'resume_subscription_dto.g.dart';

@JsonSerializable()
class ResumeSubscriptionDto {
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

  ResumeSubscriptionDto({
    required this.success,
    required this.message,
    required this.cancelAtPeriodEnd,
    required this.currentPeriodEnd,
    required this.status,
  });

  factory ResumeSubscriptionDto.fromJson(Map<String, dynamic> json) {
    return _$ResumeSubscriptionDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ResumeSubscriptionDtoToJson(this);
  }
}
