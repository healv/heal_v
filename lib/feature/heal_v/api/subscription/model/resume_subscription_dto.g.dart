// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_subscription_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResumeSubscriptionDto _$ResumeSubscriptionDtoFromJson(
        Map<String, dynamic> json) =>
    ResumeSubscriptionDto(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      cancelAtPeriodEnd: json['cancelAtPeriodEnd'] as bool?,
      currentPeriodEnd: (json['currentPeriodEnd'] as num?)?.toInt(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$ResumeSubscriptionDtoToJson(
        ResumeSubscriptionDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'cancelAtPeriodEnd': instance.cancelAtPeriodEnd,
      'currentPeriodEnd': instance.currentPeriodEnd,
      'status': instance.status,
    };
