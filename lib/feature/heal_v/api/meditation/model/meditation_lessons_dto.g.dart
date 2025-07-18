// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meditation_lessons_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeditationLessonsDto _$MeditationLessonsDtoFromJson(
        Map<String, dynamic> json) =>
    MeditationLessonsDto(
      lessons: (json['lessons'] as List<dynamic>?)
          ?.map((e) => MeditationLessonDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as String?,
      title: json['title'] as String?,
      order: (json['order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MeditationLessonsDtoToJson(
        MeditationLessonsDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'order': instance.order,
      'lessons': instance.lessons,
    };

MeditationLessonDto _$MeditationLessonDtoFromJson(Map<String, dynamic> json) =>
    MeditationLessonDto(
      id: json['id'] as String?,
      title: json['title'] as String?,
      order: (json['order'] as num?)?.toInt(),
      poses: (json['poses'] as num?)?.toInt(),
      description: json['description'] as String?,
      preview: json['preview'] == null
          ? null
          : MeditationLessonPreviewDto.fromJson(
              json['preview'] as Map<String, dynamic>),
      media: json['media'] == null
          ? null
          : MeditationLessonMediaDto.fromJson(
              json['media'] as Map<String, dynamic>),
      weekId: json['weekId'] as String?,
      isCompleted: json['isCompleted'] as bool?,
      isAccessible: json['isAccessible'] as bool?,
      hasSubscriptionAccess: json['hasSubscriptionAccess'] as bool?,
      requiresSubscription: json['requiresSubscription'] as bool?,
    );

Map<String, dynamic> _$MeditationLessonDtoToJson(
        MeditationLessonDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'order': instance.order,
      'poses': instance.poses,
      'description': instance.description,
      'preview': instance.preview,
      'media': instance.media,
      'weekId': instance.weekId,
      'isCompleted': instance.isCompleted,
      'isAccessible': instance.isAccessible,
      'hasSubscriptionAccess': instance.hasSubscriptionAccess,
      'requiresSubscription': instance.requiresSubscription,
    };

MeditationLessonPreviewDto _$MeditationLessonPreviewDtoFromJson(
        Map<String, dynamic> json) =>
    MeditationLessonPreviewDto(
      name: json['name'] as String?,
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$MeditationLessonPreviewDtoToJson(
        MeditationLessonPreviewDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'width': instance.width,
      'height': instance.height,
      'url': instance.url,
    };

MeditationLessonMediaDto _$MeditationLessonMediaDtoFromJson(
        Map<String, dynamic> json) =>
    MeditationLessonMediaDto(
      name: json['name'] as String?,
      ext: json['ext'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$MeditationLessonMediaDtoToJson(
        MeditationLessonMediaDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'ext': instance.ext,
      'url': instance.url,
    };
