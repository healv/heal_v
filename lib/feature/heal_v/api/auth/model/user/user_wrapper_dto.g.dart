// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_wrapper_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserWrapperDto _$UserWrapperDtoFromJson(Map<String, dynamic> json) =>
    UserWrapperDto(
      user: json['user'] == null
          ? null
          : UserDto.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserWrapperDtoToJson(UserWrapperDto instance) =>
    <String, dynamic>{
      'user': instance.user,
    };
