// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
      email: json['email'] as String?,
      name: json['name'] as String?,
      lastName: json['lastName'] as String?,
      birthDate: json['birthDate'] as String?,
      avatar: json['avatar'] == null
          ? null
          : AvatarDto.fromJson(json['avatar'] as Map<String, dynamic>),
      progress: json['progress'] == null
          ? null
          : ProgressDto.fromJson(json['progress'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String?,
      settings: json['settings'] == null
          ? null
          : SettingsDto.fromJson(json['settings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'lastName': instance.lastName,
      'birthDate': instance.birthDate,
      'avatar': instance.avatar,
      'progress': instance.progress,
      'createdAt': instance.createdAt,
      'settings': instance.settings,
    };

AvatarDto _$AvatarDtoFromJson(Map<String, dynamic> json) => AvatarDto(
      name: json['name'] as String?,
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$AvatarDtoToJson(AvatarDto instance) => <String, dynamic>{
      'name': instance.name,
      'width': instance.width,
      'height': instance.height,
      'url': instance.url,
    };

ProgressDto _$ProgressDtoFromJson(Map<String, dynamic> json) => ProgressDto(
      breathing: (json['breathing'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, Map<String, bool>.from(e as Map)),
      ),
      meditation: (json['meditation'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, Map<String, bool>.from(e as Map)),
      ),
      stretching: (json['stretching'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, Map<String, bool>.from(e as Map)),
      ),
    );

Map<String, dynamic> _$ProgressDtoToJson(ProgressDto instance) =>
    <String, dynamic>{
      'breathing': instance.breathing,
      'meditation': instance.meditation,
      'stretching': instance.stretching,
    };

SettingsDto _$SettingsDtoFromJson(Map<String, dynamic> json) => SettingsDto(
      language: json['language'] as String?,
    );

Map<String, dynamic> _$SettingsDtoToJson(SettingsDto instance) =>
    <String, dynamic>{
      'language': instance.language,
    };
