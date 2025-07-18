// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breathing_week_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BreathingWeekDto _$BreathingWeekDtoFromJson(Map<String, dynamic> json) =>
    BreathingWeekDto(
      id: json['id'] as String?,
      title: json['title'] as String?,
      order: (json['order'] as num?)?.toInt(),
      isAccessible: json['isAccessible'] as bool?,
      isCompleted: json['isCompleted'] as bool?,
      hasSubscriptionAccess: json['hasSubscriptionAccess'] as bool?,
      requiresSubscription: json['requiresSubscription'] as bool?,
    );

Map<String, dynamic> _$BreathingWeekDtoToJson(BreathingWeekDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'order': instance.order,
      'isAccessible': instance.isAccessible,
      'isCompleted': instance.isCompleted,
      'hasSubscriptionAccess': instance.hasSubscriptionAccess,
      'requiresSubscription': instance.requiresSubscription,
    };
