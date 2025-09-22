// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_plans_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionPlansDto _$SubscriptionPlansDtoFromJson(
        Map<String, dynamic> json) =>
    SubscriptionPlansDto(
      success: json['success'] as bool?,
      plans: (json['plans'] as List<dynamic>?)
          ?.map((e) =>
              SubscriptionPlanItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubscriptionPlansDtoToJson(
        SubscriptionPlansDto instance) =>
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
      metadata: json['metadata'] as Map<String, dynamic>?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      prices: (json['prices'] as List<dynamic>?)
          ?.map((e) =>
              SubscriptionPlanItemPriceDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      marketingFeatures: (json['marketingFeatures'] as List<dynamic>?)
          ?.map((e) => SubscriptionPlanItemMarketingFeatureDto.fromJson(
              e as Map<String, dynamic>))
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
      'marketingFeatures': instance.marketingFeatures,
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

SubscriptionPlanItemMarketingFeatureDto
    _$SubscriptionPlanItemMarketingFeatureDtoFromJson(
            Map<String, dynamic> json) =>
        SubscriptionPlanItemMarketingFeatureDto(
          name: json['name'] as String?,
        );

Map<String, dynamic> _$SubscriptionPlanItemMarketingFeatureDtoToJson(
        SubscriptionPlanItemMarketingFeatureDto instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
