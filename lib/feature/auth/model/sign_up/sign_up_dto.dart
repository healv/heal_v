import 'package:heal_v/feature/auth/model/user/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_up_dto.g.dart';

@JsonSerializable()
class SignUpDto {
  @JsonKey(name: "accessToken")
  final String? accessToken;
  @JsonKey(name: "user")
  final User? user;

  SignUpDto({
    this.accessToken,
    this.user,
  });

  factory SignUpDto.fromJson(Map<String, dynamic> json) {
    return _$SignUpDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SignUpDtoToJson(this);
  }
}
