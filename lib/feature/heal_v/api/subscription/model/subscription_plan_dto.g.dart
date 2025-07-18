// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_plan_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionPlanDto _$SubscriptionPlanDtoFromJson(Map<String, dynamic> json) =>
    SubscriptionPlanDto(
      success: json['success'] as bool?,
      plans: (json['plans'] as List<dynamic>?)
          ?.map((e) =>
              SubscriptionPlanItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubscriptionPlanDtoToJson(
        SubscriptionPlanDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'plans': instance.plans,
    };

SubscriptionPlanItemDto _$SubscriptionPlanItemDtoFromJson(
        Map<String, dynamic> json) =>
    SubscriptionPlanItemDto(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      metadata: json['metadata'] == null
          ? null
          : SubscriptionPlanItemMetaDataDto.fromJson(
              json['metadata'] as Map<String, dynamic>),
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      prices: (json['prices'] as List<dynamic>?)
          ?.map((e) =>
              SubscriptionPlanItemPriceDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubscriptionPlanItemDtoToJson(
        SubscriptionPlanItemDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'metadata': instance.metadata,
      'images': instance.images,
      'prices': instance.prices,
    };

SubscriptionPlanItemMetaDataDto _$SubscriptionPlanItemMetaDataDtoFromJson(
        Map<String, dynamic> json) =>
    SubscriptionPlanItemMetaDataDto(
      category: json['category'] as String?,
      features: json['features'] as String?,
    );

Map<String, dynamic> _$SubscriptionPlanItemMetaDataDtoToJson(
        SubscriptionPlanItemMetaDataDto instance) =>
    <String, dynamic>{
      'category': instance.category,
      'features': instance.features,
    };

SubscriptionPlanItemPriceDto _$SubscriptionPlanItemPriceDtoFromJson(
        Map<String, dynamic> json) =>
    SubscriptionPlanItemPriceDto(
      id: json['id'] as String?,
      amount: (json['amount'] as num?)?.toInt(),
      currency: json['currency'] as String?,
      interval: json['interval'] as String?,
      intervalCount: (json['intervalCount'] as num?)?.toInt(),
      trialPeriodDays: (json['trialPeriodDays'] as num?)?.toInt(),
      nickname: json['nickname'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$SubscriptionPlanItemPriceDtoToJson(
        SubscriptionPlanItemPriceDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'currency': instance.currency,
      'interval': instance.interval,
      'intervalCount': instance.intervalCount,
      'trialPeriodDays': instance.trialPeriodDays,
      'nickname': instance.nickname,
      'metadata': instance.metadata,
    };
