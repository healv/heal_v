import 'package:flutter/foundation.dart';
import 'package:heal_v/feature/heal_v/api/breathing/model/breathing_lessons_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../common/dart/optional.dart';

part 'breathing_lessons.g.dart';

@JsonSerializable()
@immutable
class BreathingLessons {
  final String? id;
  final String? title;
  final int? order;
  final List<BreathingLesson>? lessons;

  const BreathingLessons({
    required this.lessons,
    required this.id,
    required this.title,
    required this.order,
  });

  BreathingLessons copyWith({
    Optional<String>? id,
    Optional<String>? title,
    Optional<int>? order,
    Optional<List<BreathingLesson>>? lessons,
  }) {
    return BreathingLessons(
      id: id?.isValid == true ? id?.value : this.id,
      title: title?.isValid == true ? title?.value : this.title,
      order: order?.isValid == true ? order?.value : this.order,
      lessons: lessons?.isValid == true ? lessons?.value : this.lessons,
    );
  }

  factory BreathingLessons.fromMap(Map<String, dynamic> map) {
    return BreathingLessons(
      id: map['id'],
      title: map['title'],
      order: map['order'],
      lessons: (map['lessons'] as List<BreathingLessonDto>?)?.map((element) => BreathingLesson.fromMap(element.toJson())).toList(),
    );
  }

  factory BreathingLessons.fromJson(Map<String, dynamic> json) {
    return _$BreathingLessonsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BreathingLessonsToJson(this);
  }
}

@JsonSerializable()
@immutable
class BreathingLesson {
  final String? id;
  final String? title;
  final int? order;
  final int? duration;
  final String? shortDescription;
  final String? description;
  final BreathingLessonPreview? preview;
  final BreathingLessonMedia? media;
  final bool? isCompleted;
  final bool? isAccessible;

  const BreathingLesson({
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

  BreathingLesson copyWith({
    Optional<String>? id,
    Optional<String>? title,
    Optional<int>? order,
    Optional<int>? duration,
    Optional<String?>? shortDescription,
    Optional<String?>? description,
    Optional<BreathingLessonPreview?>? preview,
    Optional<BreathingLessonMedia?>? media,
    Optional<bool>? isCompleted,
    Optional<bool>? isAccessible,
  }) {
    return BreathingLesson(
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

  factory BreathingLesson.fromMap(Map<String, dynamic> map) {
    return BreathingLesson(
      id: map['id'],
      title: map['title'],
      order: map['order'] as int?,
      duration: map['duration'] as int?,
      shortDescription: map['shortDescription'],
      description: map['description'] as String?,
      preview: BreathingLessonPreview.fromMap((map['preview'] as BreathingLessonPreviewDto?)?.toJson() ?? {}),
      media: BreathingLessonMedia.fromMap((map['media'] as BreathingLessonMediaDto?)?.toJson() ?? {}),
      isCompleted: map['isCompleted'] as bool?,
      isAccessible: map['isAccessible'] as bool?,
    );
  }

  factory BreathingLesson.fromJson(Map<String, dynamic> json) {
    return _$BreathingLessonFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BreathingLessonToJson(this);
  }
}

@JsonSerializable()
@immutable
class BreathingLessonPreview {
  final String? name;
  final int? width;
  final int? height;
  final String? url;

  const BreathingLessonPreview({
    required this.name,
    required this.width,
    required this.height,
    required this.url,
  });

  BreathingLessonPreview copyWith({
    Optional<String>? name,
    Optional<int>? width,
    Optional<int>? height,
    Optional<String>? url,
  }) {
    return BreathingLessonPreview(
      name: name?.isValid == true ? name?.value : this.name,
      width: width?.isValid == true ? width?.value : this.width,
      height: height?.isValid == true ? height?.value : this.height,
      url: url?.isValid == true ? url?.value : this.url,
    );
  }

  factory BreathingLessonPreview.fromMap(Map<String, dynamic> map) {
    return BreathingLessonPreview(
      name: map['name'],
      width: map['width'] as int?,
      height: map['height'] as int?,
      url: map['url'],
    );
  }

  factory BreathingLessonPreview.fromJson(Map<String, dynamic> json) {
    return _$BreathingLessonPreviewFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BreathingLessonPreviewToJson(this);
  }
}

@JsonSerializable()
@immutable
class BreathingLessonMedia {
  final String? name;
  final String? ext;
  final String? url;

  const BreathingLessonMedia({
    required this.name,
    required this.ext,
    required this.url,
  });

  BreathingLessonMedia copyWith({
    Optional<String?>? name,
    Optional<String?>? ext,
    Optional<String?>? url,
  }) {
    return BreathingLessonMedia(
      name: name?.isValid == true ? name?.value : this.name,
      ext: ext?.isValid == true ? ext?.value : this.ext,
      url: url?.isValid == true ? url?.value : this.url,
    );
  }

  factory BreathingLessonMedia.fromMap(Map<String, dynamic> map) {
    return BreathingLessonMedia(
      name: map['name'],
      ext: map['ext'],
      url: map['url'],
    );
  }

  factory BreathingLessonMedia.fromJson(Map<String, dynamic> json) {
    return _$BreathingLessonMediaFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BreathingLessonMediaToJson(this);
  }
}
