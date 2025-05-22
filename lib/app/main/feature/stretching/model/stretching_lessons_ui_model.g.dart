// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stretching_lessons_ui_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StretchingLessons _$StretchingLessonsFromJson(Map<String, dynamic> json) =>
    StretchingLessons(
      id: json['id'] as String?,
      title: json['title'] as String?,
      order: (json['order'] as num?)?.toInt(),
      lessons: (json['lessons'] as List<dynamic>?)
          ?.map((e) => StretchingLesson.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StretchingLessonsToJson(StretchingLessons instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'order': instance.order,
      'lessons': instance.lessons,
    };

StretchingLesson _$StretchingLessonFromJson(Map<String, dynamic> json) =>
    StretchingLesson(
      id: json['id'] as String?,
      title: json['title'] as String?,
      poses: (json['poses'] as num?)?.toInt(),
      order: (json['order'] as num?)?.toInt(),
      description: json['description'] as String?,
      preview: json['preview'] == null
          ? null
          : StretchingLessonPreview.fromJson(
              json['preview'] as Map<String, dynamic>),
      media: json['media'] == null
          ? null
          : StretchingLessonMedia.fromJson(
              json['media'] as Map<String, dynamic>),
      isCompleted: json['isCompleted'] as bool?,
      isAccessible: json['isAccessible'] as bool?,
      duration: (json['duration'] as num?)?.toInt(),
    );

Map<String, dynamic> _$StretchingLessonToJson(StretchingLesson instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'order': instance.order,
      'poses': instance.poses,
      'description': instance.description,
      'preview': instance.preview,
      'media': instance.media,
      'isCompleted': instance.isCompleted,
      'isAccessible': instance.isAccessible,
      'duration': instance.duration,
    };

StretchingLessonPreview _$StretchingLessonPreviewFromJson(
        Map<String, dynamic> json) =>
    StretchingLessonPreview(
      name: json['name'] as String?,
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$StretchingLessonPreviewToJson(
        StretchingLessonPreview instance) =>
    <String, dynamic>{
      'name': instance.name,
      'width': instance.width,
      'height': instance.height,
      'url': instance.url,
    };

StretchingLessonMedia _$StretchingLessonMediaFromJson(
        Map<String, dynamic> json) =>
    StretchingLessonMedia(
      name: json['name'] as String?,
      ext: json['ext'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$StretchingLessonMediaToJson(
        StretchingLessonMedia instance) =>
    <String, dynamic>{
      'name': instance.name,
      'ext': instance.ext,
      'url': instance.url,
    };
