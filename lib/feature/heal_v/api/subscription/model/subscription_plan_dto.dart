import 'package:json_annotation/json_annotation.dart';

part 'subscription_plan_dto.g.dart';

@JsonSerializable()
class SubscriptionPlanDto {
  @JsonKey(name: "success")
  final bool? success;
  @JsonKey(name: "plans")
  final List<SubscriptionPlanItemDto>? plans;

  SubscriptionPlanDto({
    required this.success,
    required this.plans,
  });

  factory SubscriptionPlanDto.fromJson(Map<String, dynamic> json) {
    return _$SubscriptionPlanDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SubscriptionPlanDtoToJson(this);
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
  final SubscriptionPlanItemMetaDataDto? metadata;
  @JsonKey(name: "images")
  final List<String>? images;
  @JsonKey(name: "prices")
  final List<SubscriptionPlanItemPriceDto>? prices;

  const SubscriptionPlanItemDto({
    required this.id,
    required this.name,
    required this.description,
    required this.metadata,
    required this.images,
    required this.prices,
  });

  factory SubscriptionPlanItemDto.fromJson(Map<String, dynamic> json) {
    return _$SubscriptionPlanItemDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SubscriptionPlanItemDtoToJson(this);
  }
}

@JsonSerializable()
class SubscriptionPlanItemMetaDataDto {
  @JsonKey(name: "category")
  final String? category;
  @JsonKey(name: "features")
  final String? features;

  const SubscriptionPlanItemMetaDataDto({
    required this.category,
    required this.features,
  });

  factory SubscriptionPlanItemMetaDataDto.fromJson(Map<String, dynamic> json) {
    return _$SubscriptionPlanItemMetaDataDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SubscriptionPlanItemMetaDataDtoToJson(this);
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
