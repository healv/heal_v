// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_plan_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionPlanDto _$SubscriptionPlanDtoFromJson(Map<String, dynamic> json) =>
    SubscriptionPlanDto(
      success: json['success'] as bool?,
      plan: json['plans'] == null
          ? null
          : SubscriptionPlanItemDto.fromJson(
              json['plans'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubscriptionPlanDtoToJson(
        SubscriptionPlanDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'plans': instance.plan,
    };
