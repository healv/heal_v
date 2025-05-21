// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meditation_lessons_ui_model.dart';

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
      'lessons': instance.lessons,
      'id': instance.id,
      'title': instance.title,
      'order': instance.order,
    };

MeditationLesson _$MeditationLessonFromJson(Map<String, dynamic> json) =>
    MeditationLesson(
      completed: json['completed'] as bool?,
      opened: json['opened'] as bool?,
      id: json['id'] as String?,
      weekId: json['weekId'] as String?,
      order: (json['order'] as num?)?.toInt(),
      title: json['title'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
      poses: (json['poses'] as num?)?.toInt(),
      media: (json['media'] as List<dynamic>?)
          ?.map(
              (e) => MeditationLessonMedia.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MeditationLessonToJson(MeditationLesson instance) =>
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

MeditationLessonMedia _$MeditationLessonMediaFromJson(
        Map<String, dynamic> json) =>
    MeditationLessonMedia(
      downloadURL: json['downloadURL'] as String?,
      lastModifiedTS: (json['lastModifiedTS'] as num?)?.toInt(),
      name: json['name'] as String?,
      ref: json['ref'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$MeditationLessonMediaToJson(
        MeditationLessonMedia instance) =>
    <String, dynamic>{
      'downloadURL': instance.downloadURL,
      'lastModifiedTS': instance.lastModifiedTS,
      'name': instance.name,
      'ref': instance.ref,
      'type': instance.type,
    };
