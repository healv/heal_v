// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_subscription_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateSubscriptionDto _$CreateSubscriptionDtoFromJson(
        Map<String, dynamic> json) =>
    CreateSubscriptionDto(
      subscriptionId: json['subscriptionId'] as String?,
      status: json['status'] as String?,
      message: json['message'] as String?,
      clientSecret: json['clientSecret'] as String?,
      debug: json['debug'] == null
          ? null
          : CreateSubscriptionDebugDto.fromJson(
              json['debug'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateSubscriptionDtoToJson(
        CreateSubscriptionDto instance) =>
    <String, dynamic>{
      'subscriptionId': instance.subscriptionId,
      'status': instance.status,
      'message': instance.message,
      'clientSecret': instance.clientSecret,
      'debug': instance.debug,
    };

CreateSubscriptionDebugDto _$CreateSubscriptionDebugDtoFromJson(
        Map<String, dynamic> json) =>
    CreateSubscriptionDebugDto(
      hasClientSecret: json['hasClientSecret'] as bool?,
      customerId: json['customerId'] as String?,
      subscriptionStatus: json['subscriptionStatus'] as String?,
    );

Map<String, dynamic> _$CreateSubscriptionDebugDtoToJson(
        CreateSubscriptionDebugDto instance) =>
    <String, dynamic>{
      'hasClientSecret': instance.hasClientSecret,
      'customerId': instance.customerId,
      'subscriptionStatus': instance.subscriptionStatus,
    };
