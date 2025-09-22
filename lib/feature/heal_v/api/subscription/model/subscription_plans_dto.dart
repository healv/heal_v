import 'package:json_annotation/json_annotation.dart';

part 'subscription_plans_dto.g.dart';

@JsonSerializable()
class SubscriptionPlansDto {
  @JsonKey(name: "success")
  final bool? success;
  @JsonKey(name: "plans")
  final List<SubscriptionPlanItemDto>? plans;

  SubscriptionPlansDto({
    required this.success,
    required this.plans,
  });

  factory SubscriptionPlansDto.fromJson(Map<String, dynamic> json) {
    return _$SubscriptionPlansDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SubscriptionPlansDtoToJson(this);
  }
}

@JsonSerializable()
class SubscriptionPlanItemDto {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "metadata")
  final Map<String, dynamic>? metadata;
  @JsonKey(name: "images")
  final List<String>? images;
  @JsonKey(name: "prices")
  final List<SubscriptionPlanItemPriceDto>? prices;
  @JsonKey(name: "marketingFeatures")
  final List<SubscriptionPlanItemMarketingFeatureDto>? marketingFeatures;

  const SubscriptionPlanItemDto({
    required this.id,
    required this.name,
    required this.description,
    required this.metadata,
    required this.images,
    required this.prices,
    required this.marketingFeatures,
  });

  factory SubscriptionPlanItemDto.fromJson(Map<String, dynamic> json) {
    return _$SubscriptionPlanItemDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SubscriptionPlanItemDtoToJson(this);
  }
}

@JsonSerializable()
class SubscriptionPlanItemPriceDto {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "amount")
  final int? amount;
  @JsonKey(name: "currency")
  final String? currency;
  @JsonKey(name: "interval")
  final String? interval;
  @JsonKey(name: "intervalCount")
  final int? intervalCount;
  @JsonKey(name: "trialPeriodDays")
  final int? trialPeriodDays;
  @JsonKey(name: "nickname")
  final String? nickname;
  @JsonKey(name: "metadata")
  final Map<String, dynamic>? metadata;

  const SubscriptionPlanItemPriceDto({
    required this.id,
    required this.amount,
    required this.currency,
    required this.interval,
    required this.intervalCount,
    required this.trialPeriodDays,
    required this.nickname,
    required this.metadata,
  });

  factory SubscriptionPlanItemPriceDto.fromJson(Map<String, dynamic> json) {
    return _$SubscriptionPlanItemPriceDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SubscriptionPlanItemPriceDtoToJson(this);
  }
}

@JsonSerializable()
class SubscriptionPlanItemMarketingFeatureDto {
  @JsonKey(name: "name")
  final String? name;

  const SubscriptionPlanItemMarketingFeatureDto({
    required this.name,
  });

  factory SubscriptionPlanItemMarketingFeatureDto.fromJson(Map<String, dynamic> json) {
    return _$SubscriptionPlanItemMarketingFeatureDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SubscriptionPlanItemMarketingFeatureDtoToJson(this);
  }
}
