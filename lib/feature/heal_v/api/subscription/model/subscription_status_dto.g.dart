// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_status_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionStatusDto _$SubscriptionStatusDtoFromJson(
        Map<String, dynamic> json) =>
    SubscriptionStatusDto(
      status: json['status'] as String?,
      isFull: json['isFull'] as bool?,
      currentPeriodEnd: (json['currentPeriodEnd'] as num?)?.toInt(),
      currentPeriodStart: (json['currentPeriodStart'] as num?)?.toInt(),
      cancelAtPeriodEnd: json['cancelAtPeriodEnd'] as bool?,
      canceledAt: (json['canceledAt'] as num?)?.toInt(),
      subscriptionId: json['subscriptionId'] as String?,
    );

Map<String, dynamic> _$SubscriptionStatusDtoToJson(
        SubscriptionStatusDto instance) =>
    <String, dynamic>{
      'status': instance.status,
      'isFull': instance.isFull,
      'currentPeriodEnd': instance.currentPeriodEnd,
      'currentPeriodStart': instance.currentPeriodStart,
      'cancelAtPeriodEnd': instance.cancelAtPeriodEnd,
      'canceledAt': instance.canceledAt,
      'subscriptionId': instance.subscriptionId,
    };
