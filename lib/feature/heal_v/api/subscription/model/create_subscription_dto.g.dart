// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_subscription_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateSubscriptionDto _$CreateSubscriptionDtoFromJson(
        Map<String, dynamic> json) =>
    CreateSubscriptionDto(
      success: json['success'] as bool?,
      subscriptionId: json['subscriptionId'] as String?,
      status: json['status'] as String?,
      productId: json['productId'] as String?,
      planName: json['planName'] as String?,
      billingInterval: json['billingInterval'] as String?,
      amount: (json['amount'] as num?)?.toInt(),
      currency: json['currency'] as String?,
      message: json['message'] as String?,
      trialEnd: json['trialEnd'] as String?,
      clientSecret: json['clientSecret'] as String?,
      requiresPayment: json['requiresPayment'] as bool?,
      customerId: json['customerId'] as String?,
    );

Map<String, dynamic> _$CreateSubscriptionDtoToJson(
        CreateSubscriptionDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'subscriptionId': instance.subscriptionId,
      'status': instance.status,
      'productId': instance.productId,
      'planName': instance.planName,
      'billingInterval': instance.billingInterval,
      'amount': instance.amount,
      'currency': instance.currency,
      'message': instance.message,
      'trialEnd': instance.trialEnd,
      'clientSecret': instance.clientSecret,
      'requiresPayment': instance.requiresPayment,
      'customerId': instance.customerId,
    };
