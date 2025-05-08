import 'package:heal_v/feature/heal_v/api/auth/model/user/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_wrapper_dto.g.dart';

@JsonSerializable()
class UserWrapperDto {
  @JsonKey(name: "user")
  final UserDto? user;

  UserWrapperDto({
    this.user,
  });

  factory UserWrapperDto.fromJson(Map<String, dynamic> json) {
    return _$UserWrapperDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserWrapperDtoToJson(this);
  }
}
