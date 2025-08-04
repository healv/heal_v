// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_status_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionStatusDto _$SubscriptionStatusDtoFromJson(
        Map<String, dynamic> json) =>
    SubscriptionStatusDto(
      status: json['status'] as String?,
      stripeCustomerId: json['stripeCustomerId'] as String?,
      subscriptionId: json['subscriptionId'] as String?,
      productId: json['productId'] as String?,
      priceId: json['priceId'] as String?,
      planName: json['planName'] as String?,
      billingInterval: json['billingInterval'] as String?,
      subscriptionStartDate: json['subscriptionStartDate'] as String?,
      currentPeriodEnd: json['currentPeriodEnd'] as String?,
      cancelAtPeriodEnd: json['cancelAtPeriodEnd'] as bool?,
    );

Map<String, dynamic> _$SubscriptionStatusDtoToJson(
        SubscriptionStatusDto instance) =>
    <String, dynamic>{
      'status': instance.status,
      'stripeCustomerId': instance.stripeCustomerId,
      'subscriptionId': instance.subscriptionId,
      'productId': instance.productId,
      'priceId': instance.priceId,
      'planName': instance.planName,
      'billingInterval': instance.billingInterval,
      'subscriptionStartDate': instance.subscriptionStartDate,
      'currentPeriodEnd': instance.currentPeriodEnd,
      'cancelAtPeriodEnd': instance.cancelAtPeriodEnd,
    };
