// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_subscription_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CancelSubscriptionDto _$CancelSubscriptionDtoFromJson(
        Map<String, dynamic> json) =>
    CancelSubscriptionDto(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      subscription: json['subscription'] == null
          ? null
          : SubscriptionDto.fromJson(
              json['subscription'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CancelSubscriptionDtoToJson(
        CancelSubscriptionDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'subscription': instance.subscription,
    };
