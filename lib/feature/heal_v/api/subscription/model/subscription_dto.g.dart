// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionDto _$SubscriptionDtoFromJson(Map<String, dynamic> json) =>
    SubscriptionDto(
      id: json['id'] as String?,
      status: json['status'] as String?,
      cancelAtPeriodEnd: json['cancelAtPeriodEnd'] as bool?,
      currentPeriodEnd: json['currentPeriodEnd'] as String?,
    );

Map<String, dynamic> _$SubscriptionDtoToJson(SubscriptionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'cancelAtPeriodEnd': instance.cancelAtPeriodEnd,
      'currentPeriodEnd': instance.currentPeriodEnd,
    };
