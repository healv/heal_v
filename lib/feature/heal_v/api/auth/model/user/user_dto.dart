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
  @JsonKey(name: "photoURL")
  final String? photoURL;
  @JsonKey(name: "subscription")
  final Subscription? subscription;
  @JsonKey(name: "preferences")
  final Preferences? preferences;
  @JsonKey(name: "progress")
  final Progress? progress;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "birthDate")
  final String? birthDate;

  UserDto({
    this.email,
    this.name,
    this.lastName,
    this.photoURL,
    this.subscription,
    this.preferences,
    this.progress,
    this.createdAt,
    this.birthDate,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return _$UserDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserDtoToJson(this);
  }
}

@JsonSerializable()
class Subscription {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "plan")
  final dynamic plan;
  @JsonKey(name: "expiresAt")
  final dynamic expiresAt;

  Subscription({
    this.status,
    this.plan,
    this.expiresAt,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return _$SubscriptionFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SubscriptionToJson(this);
  }
}

@JsonSerializable()
class Preferences {
  @JsonKey(name: "notifications")
  final bool? notifications;

  Preferences({
    this.notifications,
  });

  factory Preferences.fromJson(Map<String, dynamic> json) {
    return _$PreferencesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PreferencesToJson(this);
  }
}

@JsonSerializable()
class Progress {
  @JsonKey(name: "completedLessons")
  final List<dynamic>? completedLessons;
  @JsonKey(name: "lastLessonId")
  final dynamic lastLessonId;

  Progress({
    this.completedLessons,
    this.lastLessonId,
  });

  factory Progress.fromJson(Map<String, dynamic> json) {
    return _$ProgressFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProgressToJson(this);
  }
}
