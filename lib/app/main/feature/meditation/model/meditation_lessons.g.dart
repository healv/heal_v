// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meditation_lessons.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeditationLessons _$MeditationLessonsFromJson(Map<String, dynamic> json) =>
    MeditationLessons(
      lessons: (json['lessons'] as List<dynamic>?)
          ?.map((e) => MeditationLesson.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as String?,
      title: json['title'] as String?,
      order: (json['order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MeditationLessonsToJson(MeditationLessons instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'order': instance.order,
      'lessons': instance.lessons,
    };

MeditationLesson _$MeditationLessonFromJson(Map<String, dynamic> json) =>
    MeditationLesson(
      id: json['id'] as String?,
      title: json['title'] as String?,
      order: (json['order'] as num?)?.toInt(),
      duration: (json['duration'] as num?)?.toInt(),
      shortDescription: json['shortDescription'] as String?,
      description: json['description'] as String?,
      preview: json['preview'] == null
          ? null
          : MeditationLessonPreview.fromJson(
              json['preview'] as Map<String, dynamic>),
      media: json['media'] == null
          ? null
          : MeditationLessonMedia.fromJson(
              json['media'] as Map<String, dynamic>),
      weekId: json['weekId'] as String?,
      isCompleted: json['isCompleted'] as bool?,
      isAccessible: json['isAccessible'] as bool?,
      hasSubscriptionAccess: json['hasSubscriptionAccess'] as bool?,
      requiresSubscription: json['requiresSubscription'] as bool?,
    );

Map<String, dynamic> _$MeditationLessonToJson(MeditationLesson instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'order': instance.order,
      'duration': instance.duration,
      'shortDescription': instance.shortDescription,
      'description': instance.description,
      'preview': instance.preview,
      'media': instance.media,
      'weekId': instance.weekId,
      'isCompleted': instance.isCompleted,
      'isAccessible': instance.isAccessible,
      'hasSubscriptionAccess': instance.hasSubscriptionAccess,
      'requiresSubscription': instance.requiresSubscription,
    };

MeditationLessonPreview _$MeditationLessonPreviewFromJson(
        Map<String, dynamic> json) =>
    MeditationLessonPreview(
      name: json['name'] as String?,
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$MeditationLessonPreviewToJson(
        MeditationLessonPreview instance) =>
    <String, dynamic>{
      'name': instance.name,
      'width': instance.width,
      'height': instance.height,
      'url': instance.url,
    };

MeditationLessonMedia _$MeditationLessonMediaFromJson(
        Map<String, dynamic> json) =>
    MeditationLessonMedia(
      name: json['name'] as String?,
      ext: json['ext'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$MeditationLessonMediaToJson(
        MeditationLessonMedia instance) =>
    <String, dynamic>{
      'name': instance.name,
      'ext': instance.ext,
      'url': instance.url,
    };
