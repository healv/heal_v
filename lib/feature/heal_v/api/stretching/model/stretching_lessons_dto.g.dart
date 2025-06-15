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
      'id': instance.id,
      'title': instance.title,
      'order': instance.order,
      'lessons': instance.lessons,
    };

StretchingLessonDto _$StretchingLessonDtoFromJson(Map<String, dynamic> json) =>
    StretchingLessonDto(
      id: json['id'] as String?,
      title: json['title'] as String?,
      order: (json['order'] as num?)?.toInt(),
      poses: (json['poses'] as num?)?.toInt(),
      duration: (json['duration'] as num?)?.toInt(),
      description: json['description'] as String?,
      preview: json['preview'] == null
          ? null
          : StretchingLessonPreviewDto.fromJson(
              json['preview'] as Map<String, dynamic>),
      media: json['media'] == null
          ? null
          : StretchingLessonMediaDto.fromJson(
              json['media'] as Map<String, dynamic>),
      isCompleted: json['isCompleted'] as bool?,
      isAccessible: json['isAccessible'] as bool?,
    );

Map<String, dynamic> _$StretchingLessonDtoToJson(
        StretchingLessonDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'order': instance.order,
      'poses': instance.poses,
      'duration': instance.duration,
      'description': instance.description,
      'preview': instance.preview,
      'media': instance.media,
      'isCompleted': instance.isCompleted,
      'isAccessible': instance.isAccessible,
    };

StretchingLessonPreviewDto _$StretchingLessonPreviewDtoFromJson(
        Map<String, dynamic> json) =>
    StretchingLessonPreviewDto(
      name: json['name'] as String?,
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$StretchingLessonPreviewDtoToJson(
        StretchingLessonPreviewDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'width': instance.width,
      'height': instance.height,
      'url': instance.url,
    };

StretchingLessonMediaDto _$StretchingLessonMediaDtoFromJson(
        Map<String, dynamic> json) =>
    StretchingLessonMediaDto(
      name: json['name'] as String?,
      ext: json['ext'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$StretchingLessonMediaDtoToJson(
        StretchingLessonMediaDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'ext': instance.ext,
      'url': instance.url,
    };
