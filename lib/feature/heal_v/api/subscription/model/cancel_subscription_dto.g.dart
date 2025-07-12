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
      cancelAtPeriodEnd: json['cancelAtPeriodEnd'] as bool?,
      currentPeriodEnd: (json['currentPeriodEnd'] as num?)?.toInt(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$CancelSubscriptionDtoToJson(
        CancelSubscriptionDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'cancelAtPeriodEnd': instance.cancelAtPeriodEnd,
      'currentPeriodEnd': instance.currentPeriodEnd,
      'status': instance.status,
    };
