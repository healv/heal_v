import 'package:json_annotation/json_annotation.dart';

part 'create_subscription_request_dto.g.dart';

@JsonSerializable()
class CreateSubscriptionRequestDto {
  @JsonKey(name: "priceId")
  final String? priceId;

  CreateSubscriptionRequestDto({required this.priceId});

  factory CreateSubscriptionRequestDto.fromJson(Map<String, dynamic> json) {
    return _$CreateSubscriptionRequestDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CreateSubscriptionRequestDtoToJson(this);
  }
}
