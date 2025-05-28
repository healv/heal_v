import 'package:json_annotation/json_annotation.dart';

part 'validate_user_dto.g.dart';

@JsonSerializable()
class ValidateUserDto {
  @JsonKey(name: "found")
  final bool? found;

  ValidateUserDto({
    this.found,
  });

  factory ValidateUserDto.fromJson(Map<String, dynamic> json) {
    return _$ValidateUserDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ValidateUserDtoToJson(this);
  }
}
