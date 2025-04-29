// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stretching_lessons_ui_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StretchingLessons _$StretchingLessonsFromJson(Map<String, dynamic> json) =>
    StretchingLessons(
      lessons: (json['lessons'] as List<dynamic>?)
          ?.map((e) => StretchingLesson.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as String?,
      title: json['title'] as String?,
      order: (json['order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$StretchingLessonsToJson(StretchingLessons instance) =>
    <String, dynamic>{
      'lessons': instance.lessons,
      'id': instance.id,
      'title': instance.title,
      'order': instance.order,
    };

StretchingLesson _$StretchingLessonFromJson(Map<String, dynamic> json) =>
    StretchingLesson(
      completed: json['completed'] as bool?,
      opened: json['opened'] as bool?,
      id: json['id'] as String?,
      weekId: json['weekId'] as String?,
      order: (json['order'] as num?)?.toInt(),
      title: json['title'] as String?,
      duration: json['duration'] as String?,
      poses: (json['poses'] as num?)?.toInt(),
      media: (json['media'] as List<dynamic>?)
          ?.map(
              (e) => StretchingLessonMedia.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StretchingLessonToJson(StretchingLesson instance) =>
    <String, dynamic>{
      'completed': instance.completed,
      'opened': instance.opened,
      'id': instance.id,
      'weekId': instance.weekId,
      'order': instance.order,
      'title': instance.title,
      'duration': instance.duration,
      'poses': instance.poses,
      'media': instance.media,
    };

StretchingLessonMedia _$StretchingLessonMediaFromJson(
        Map<String, dynamic> json) =>
    StretchingLessonMedia(
      downloadURL: json['downloadURL'] as String?,
      lastModifiedTS: (json['lastModifiedTS'] as num?)?.toInt(),
      name: json['name'] as String?,
      ref: json['ref'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$StretchingLessonMediaToJson(
        StretchingLessonMedia instance) =>
    <String, dynamic>{
      'downloadURL': instance.downloadURL,
      'lastModifiedTS': instance.lastModifiedTS,
      'name': instance.name,
      'ref': instance.ref,
      'type': instance.type,
    };
