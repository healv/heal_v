import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../common/dart/optional.dart';
import '../../../../../feature/heal_v/api/meditation/model/meditation_lessons_dto.dart';

part 'meditation_lessons.g.dart';

@JsonSerializable()
@immutable
class MeditationLessons {
  final String? id;
  final String? title;
  final int? order;
  final List<MeditationLesson>? lessons;

  const MeditationLessons({
    required this.lessons,
    required this.id,
    required this.title,
    required this.order,
  });

  MeditationLessons copyWith({
    Optional<String>? id,
    Optional<String>? title,
    Optional<int>? order,
    Optional<List<MeditationLesson>>? lessons,
  }) {
    return MeditationLessons(
      id: id?.isValid == true ? id?.value : this.id,
      title: title?.isValid == true ? title?.value : this.title,
      order: order?.isValid == true ? order?.value : this.order,
      lessons: lessons?.isValid == true ? lessons?.value : this.lessons,
    );
  }

  factory MeditationLessons.fromMap(Map<String, dynamic> map) {
    return MeditationLessons(
      id: map['id'],
      title: map['title'],
      order: map['order'],
      lessons: (map['lessons'] as List<MeditationLessonDto>?)?.map((element) => MeditationLesson.fromMap(element.toJson())).toList(),
    );
  }

  factory MeditationLessons.fromJson(Map<String, dynamic> json) {
    return _$MeditationLessonsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MeditationLessonsToJson(this);
  }
}

@JsonSerializable()
@immutable
class MeditationLesson {
  final String? id;
  final String? title;
  final int? order;
  final int? duration;
  final String? shortDescription;
  final String? description;
  final MeditationLessonPreview? preview;
  final MeditationLessonMedia? media;
  final bool? isCompleted;
  final bool? isAccessible;

  const MeditationLesson({
    required this.id,
    required this.title,
    required this.order,
    required this.duration,
    required this.shortDescription,
    required this.description,
    required this.preview,
    required this.media,
    required this.isCompleted,
    required this.isAccessible,
  });

  MeditationLesson copyWith({
    Optional<String>? id,
    Optional<String>? title,
    Optional<int>? order,
    Optional<int>? duration,
    Optional<String?>? shortDescription,
    Optional<String?>? description,
    Optional<MeditationLessonPreview?>? preview,
    Optional<MeditationLessonMedia?>? media,
    Optional<bool>? isCompleted,
    Optional<bool>? isAccessible,
  }) {
    return MeditationLesson(
      id: id?.isValid == true ? id?.value : this.id,
      title: title?.isValid == true ? title?.value : this.title,
      order: order?.isValid == true ? order?.value : this.order,
      duration: duration?.isValid == true ? duration?.value : this.duration,
      shortDescription: shortDescription?.isValid == true ? shortDescription?.value : this.shortDescription,
      description: description?.isValid == true ? description?.value : this.description,
      preview: preview?.isValid == true ? preview?.value : this.preview,
      media: media?.isValid == true ? media?.value : this.media,
      isCompleted: isCompleted?.isValid == true ? isCompleted?.value : this.isCompleted,
      isAccessible: isAccessible?.isValid == true ? isAccessible?.value : this.isAccessible,
    );
  }

  factory MeditationLesson.fromMap(Map<String, dynamic> map) {
    return MeditationLesson(
      id: map['id'],
      title: map['title'],
      order: map['order'] as int?,
      duration: map['duration'] as int?,
      shortDescription: map['shortDescription'],
      description: map['description'] as String?,
      preview: MeditationLessonPreview.fromMap((map['preview'] as MeditationLessonPreviewDto?)?.toJson() ?? {}),
      media: MeditationLessonMedia.fromMap((map['media'] as MeditationLessonMediaDto?)?.toJson() ?? {}),
      isCompleted: map['isCompleted'] as bool?,
      isAccessible: map['isAccessible'] as bool?,
    );
  }

  factory MeditationLesson.fromJson(Map<String, dynamic> json) {
    return _$MeditationLessonFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MeditationLessonToJson(this);
  }
}

@JsonSerializable()
@immutable
class MeditationLessonPreview {
  final String? name;
  final int? width;
  final int? height;
  final String? url;

  const MeditationLessonPreview({
    required this.name,
    required this.width,
    required this.height,
    required this.url,
  });

  MeditationLessonPreview copyWith({
    Optional<String>? name,
    Optional<int>? width,
    Optional<int>? height,
    Optional<String>? url,
  }) {
    return MeditationLessonPreview(
      name: name?.isValid == true ? name?.value : this.name,
      width: width?.isValid == true ? width?.value : this.width,
      height: height?.isValid == true ? height?.value : this.height,
      url: url?.isValid == true ? url?.value : this.url,
    );
  }

  factory MeditationLessonPreview.fromMap(Map<String, dynamic> map) {
    return MeditationLessonPreview(
      name: map['name'],
      width: map['width'] as int?,
      height: map['height'] as int?,
      url: map['url'],
    );
  }

  factory MeditationLessonPreview.fromJson(Map<String, dynamic> json) {
    return _$MeditationLessonPreviewFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MeditationLessonPreviewToJson(this);
  }
}

@JsonSerializable()
@immutable
class MeditationLessonMedia {
  final String? name;
  final String? ext;
  final String? url;

  const MeditationLessonMedia({
    required this.name,
    required this.ext,
    required this.url,
  });

  MeditationLessonMedia copyWith({
    Optional<String?>? name,
    Optional<String?>? ext,
    Optional<String?>? url,
  }) {
    return MeditationLessonMedia(
      name: name?.isValid == true ? name?.value : this.name,
      ext: ext?.isValid == true ? ext?.value : this.ext,
      url: url?.isValid == true ? url?.value : this.url,
    );
  }

  factory MeditationLessonMedia.fromMap(Map<String, dynamic> map) {
    return MeditationLessonMedia(
      name: map['name'],
      ext: map['ext'],
      url: map['url'],
    );
  }

  factory MeditationLessonMedia.fromJson(Map<String, dynamic> json) {
    return _$MeditationLessonMediaFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MeditationLessonMediaToJson(this);
  }
}
