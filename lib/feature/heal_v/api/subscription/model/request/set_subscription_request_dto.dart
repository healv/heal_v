import 'package:json_annotation/json_annotation.dart';

part 'set_subscription_request_dto.g.dart';

@JsonSerializable()
class SetSubscriptionRequestDto {
  @JsonKey(name: "priceId")
  final String? priceId;

  SetSubscriptionRequestDto({required this.priceId});

  factory SetSubscriptionRequestDto.fromJson(Map<String, dynamic> json) {
    return _$SetSubscriptionRequestDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SetSubscriptionRequestDtoToJson(this);
  }
}
