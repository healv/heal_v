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
      subscription: json['subscription'] == null
          ? null
          : SubscriptionDto.fromJson(
              json['subscription'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResumeSubscriptionDtoToJson(
        ResumeSubscriptionDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'subscription': instance.subscription,
    };
