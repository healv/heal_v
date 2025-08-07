import 'package:heal_v/feature/heal_v/api/subscription/model/subscription_plans_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subscription_plan_dto.g.dart';

@JsonSerializable()
class SubscriptionPlanDto {
  @JsonKey(name: "success")
  final bool? success;
  @JsonKey(name: "plan")
  final SubscriptionPlanItemDto? plan;

  SubscriptionPlanDto({
    required this.success,
    required this.plan,
  });

  factory SubscriptionPlanDto.fromJson(Map<String, dynamic> json) {
    return _$SubscriptionPlanDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SubscriptionPlanDtoToJson(this);
  }
}
