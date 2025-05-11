// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stretching_lessons_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StretchingLessonsDto _$StretchingLessonsDtoFromJson(
        Map<String, dynamic> json) =>
    StretchingLessonsDto(
      lessons: (json['lessons'] as List<dynamic>?)
          ?.map((e) => StretchingLessonDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as String?,
      title: json['title'] as String?,
      order: (json['order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$StretchingLessonsDtoToJson(
        StretchingLessonsDto instance) =>
    <String, dynamic>{
      'lessons': instance.lessons,
      'id': instance.id,
      'title': instance.title,
      'order': instance.order,
    };

StretchingLessonDto _$StretchingLessonDtoFromJson(Map<String, dynamic> json) =>
    StretchingLessonDto(
      completed: json['completed'] as bool?,
      opened: json['opened'] as bool?,
      id: json['id'] as String?,
      weekId: json['weekId'] as String?,
      order: (json['order'] as num?)?.toInt(),
      title: json['title'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
      poses: (json['poses'] as num?)?.toInt(),
      media: (json['media'] as List<dynamic>?)
          ?.map((e) =>
              StretchingLessonMediaDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StretchingLessonDtoToJson(
        StretchingLessonDto instance) =>
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

StretchingLessonMediaDto _$StretchingLessonMediaDtoFromJson(
        Map<String, dynamic> json) =>
    StretchingLessonMediaDto(
      downloadURL: json['downloadURL'] as String?,
      lastModifiedTS: (json['lastModifiedTS'] as num?)?.toInt(),
      name: json['name'] as String?,
      ref: json['ref'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$StretchingLessonMediaDtoToJson(
        StretchingLessonMediaDto instance) =>
    <String, dynamic>{
      'downloadURL': instance.downloadURL,
      'lastModifiedTS': instance.lastModifiedTS,
      'name': instance.name,
      'ref': instance.ref,
      'type': instance.type,
    };
