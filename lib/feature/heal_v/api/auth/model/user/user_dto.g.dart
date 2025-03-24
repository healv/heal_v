// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      email: json['email'] as String?,
      name: json['name'] as String?,
      lastName: json['lastName'] as String?,
      photoURL: json['photoURL'] as String?,
      subscription: json['subscription'] == null
          ? null
          : Subscription.fromJson(json['subscription'] as Map<String, dynamic>),
      preferences: json['preferences'] == null
          ? null
          : Preferences.fromJson(json['preferences'] as Map<String, dynamic>),
      progress: json['progress'] == null
          ? null
          : Progress.fromJson(json['progress'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'lastName': instance.lastName,
      'photoURL': instance.photoURL,
      'subscription': instance.subscription,
      'preferences': instance.preferences,
      'progress': instance.progress,
      'createdAt': instance.createdAt,
    };

Subscription _$SubscriptionFromJson(Map<String, dynamic> json) => Subscription(
      status: json['status'] as String?,
      plan: json['plan'],
      expiresAt: json['expiresAt'],
    );

Map<String, dynamic> _$SubscriptionToJson(Subscription instance) =>
    <String, dynamic>{
      'status': instance.status,
      'plan': instance.plan,
      'expiresAt': instance.expiresAt,
    };

Preferences _$PreferencesFromJson(Map<String, dynamic> json) => Preferences(
      notifications: json['notifications'] as bool?,
    );

Map<String, dynamic> _$PreferencesToJson(Preferences instance) =>
    <String, dynamic>{
      'notifications': instance.notifications,
    };

Progress _$ProgressFromJson(Map<String, dynamic> json) => Progress(
      completedLessons: json['completedLessons'] as List<dynamic>?,
      lastLessonId: json['lastLessonId'],
    );

Map<String, dynamic> _$ProgressToJson(Progress instance) => <String, dynamic>{
      'completedLessons': instance.completedLessons,
      'lastLessonId': instance.lastLessonId,
    };
