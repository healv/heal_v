import 'package:heal_v/feature/heal_v/api/subscription/model/subscription_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'resume_subscription_dto.g.dart';

@JsonSerializable()
class ResumeSubscriptionDto {
  @JsonKey(name: "success")
  final bool? success;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "subscription")
  final SubscriptionDto? subscription;

  ResumeSubscriptionDto({
    required this.success,
    required this.message,
    required this.subscription,
  });

  factory ResumeSubscriptionDto.fromJson(Map<String, dynamic> json) {
    return _$ResumeSubscriptionDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ResumeSubscriptionDtoToJson(this);
  }
}
