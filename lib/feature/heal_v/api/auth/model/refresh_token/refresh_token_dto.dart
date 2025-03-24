import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_dto.g.dart';

@JsonSerializable()
class RefreshTokenDto {
  @JsonKey(name: "accessToken")
  final String? accessToken;
  @JsonKey(name: "refreshToken")
  final String? refreshToken;

  RefreshTokenDto ({
    this.accessToken,
    this.refreshToken,
  });

  factory RefreshTokenDto.fromJson(Map<String, dynamic> json) {
    return _$RefreshTokenDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RefreshTokenDtoToJson(this);
  }
}


