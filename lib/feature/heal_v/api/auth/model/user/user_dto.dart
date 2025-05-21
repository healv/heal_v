import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "birthDate")
  final String? birthDate;
  @JsonKey(name: "avatar")
  final AvatarDto? avatar;
  @JsonKey(name: "progress")
  final ProgressDto? progress;

  // @JsonKey(name: "photoURL")
  // final String? photoURL;
  // @JsonKey(name: "subscription")
  // final Subscription? subscription;
  // @JsonKey(name: "preferences")
  // final Preferences? preferences;
  // @JsonKey(name: "createdAt")
  // final String? createdAt;

  UserDto({
    this.email,
    this.name,
    this.lastName,
    this.birthDate,
    this.avatar,
    this.progress,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return _$UserDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserDtoToJson(this);
  }
}

@JsonSerializable()
class AvatarDto {
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "width")
  final int? width;
  @JsonKey(name: "height")
  final int? height;
  @JsonKey(name: "url")
  final String? url;

  AvatarDto({
    this.name,
    this.width,
    this.height,
    this.url,
  });

  factory AvatarDto.fromJson(Map<String, dynamic> json) {
    return _$AvatarDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AvatarDtoToJson(this);
  }
}

@JsonSerializable()
class ProgressDto {
  @JsonKey(name: "breathing")
  final Map<String, Map<String, bool>>? breathing;
  @JsonKey(name: "meditation")
  final Map<String, Map<String, bool>>? meditation;
  @JsonKey(name: "stretching")
  final Map<String, Map<String, bool>>? stretching;

  ProgressDto({
    this.breathing,
    this.meditation,
    this.stretching,
  });

  factory ProgressDto.fromJson(Map<String, dynamic> json) {
    return _$ProgressDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProgressDtoToJson(this);
  }
}

// @JsonSerializable()
// class Subscription {
//   @JsonKey(name: "status")
//   final String? status;
//   @JsonKey(name: "plan")
//   final dynamic plan;
//   @JsonKey(name: "expiresAt")
//   final dynamic expiresAt;
//
//   Subscription({
//     this.status,
//     this.plan,
//     this.expiresAt,
//   });
//
//   factory Subscription.fromJson(Map<String, dynamic> json) {
//     return _$SubscriptionFromJson(json);
//   }
//
//   Map<String, dynamic> toJson() {
//     return _$SubscriptionToJson(this);
//   }
// }
//
// @JsonSerializable()
// class Preferences {
//   @JsonKey(name: "notifications")
//   final bool? notifications;
//
//   Preferences({
//     this.notifications,
//   });
//
//   factory Preferences.fromJson(Map<String, dynamic> json) {
//     return _$PreferencesFromJson(json);
//   }
//
//   Map<String, dynamic> toJson() {
//     return _$PreferencesToJson(this);
//   }
// }
//
