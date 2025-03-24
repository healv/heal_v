import 'package:heal_v/feature/heal_v/api/auth/model/user/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_dto.g.dart';

@JsonSerializable()
class LoginDto {
  @JsonKey(name: "accessToken")
  final String? accessToken;
  @JsonKey(name: "refreshToken")
  final String? refreshToken;
  @JsonKey(name: "user")
  final User? user;

  LoginDto({
    this.accessToken,
    this.refreshToken,
    this.user,
  });

  factory LoginDto.fromJson(Map<String, dynamic> json) {
    return _$LoginDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LoginDtoToJson(this);
  }
}
