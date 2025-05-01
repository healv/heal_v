import 'package:heal_v/feature/heal_v/api/auth/model/user/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_up_dto.g.dart';

@JsonSerializable()
class SignUpDto {
  @JsonKey(name: "accessToken")
  final String? accessToken;
  @JsonKey(name: "refreshToken")
  final String? refreshToken;
  @JsonKey(name: "user")
  final UserDto? user;

  SignUpDto({
    this.accessToken,
    this.refreshToken,
    this.user,
  });

  factory SignUpDto.fromJson(Map<String, dynamic> json) {
    return _$SignUpDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SignUpDtoToJson(this);
  }
}
