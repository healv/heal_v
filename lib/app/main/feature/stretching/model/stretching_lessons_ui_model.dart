import 'package:flutter/foundation.dart';
import 'package:heal_v/feature/heal_v/api/stretching/model/stretching_lessons_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../common/dart/optional.dart';

part 'stretching_lessons_ui_model.g.dart';

@JsonSerializable()
@immutable
class StretchingLessons {
  final List<StretchingLesson>? lessons;
  final String? id;
  final String? title;
  final int? order;

  const StretchingLessons({
    required this.lessons,
    required this.id,
    required this.title,
    required this.order,
  });

  StretchingLessons copyWith({
    Optional<String>? id,
    Optional<String>? title,
    Optional<int>? order,
    Optional<List<StretchingLesson>>? lessons,
  }) {
    return StretchingLessons(
      id: id?.isValid == true ? id?.value : this.id,
      title: title?.isValid == true ? title?.value : this.title,
      order: order?.isValid == true ? order?.value : this.order,
      lessons: lessons?.isValid == true ? lessons?.value : this.lessons,
    );
  }

  factory StretchingLessons.fromMap(Map<String, dynamic> map) {
    return StretchingLessons(
      id: map['id'],
      title: map['title'],
      order: map['order'],
      lessons: (map['lessons'] as List<StretchingLessonDto>?)?.map((element) => StretchingLesson.fromMap(element.toJson())).toList(),
    );
  }

  factory StretchingLessons.fromJson(Map<String, dynamic> json) {
    return _$StretchingLessonsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StretchingLessonsToJson(this);
  }

  bool isAllLessonsCompleted() => lessons?.every((item) => item.completed == true) == true;
}

@JsonSerializable()
@immutable
class StretchingLesson {
  final bool? completed;
  final bool? opened;
  final String? id;
  final String? weekId;
  final int? order;
  final String? title;
  final int? duration;
  final int? poses;
  final List<StretchingLessonMedia>? media;

  const StretchingLesson({
    required this.completed,
    required this.opened,
    required this.id,
    required this.weekId,
    required this.order,
    required this.title,
    required this.duration,
    required this.poses,
    required this.media,
  });

  StretchingLesson copyWith({
    Optional<bool>? completed,
    Optional<bool>? opened,
    Optional<String>? id,
    Optional<String>? weekId,
    Optional<int>? order,
    Optional<String>? title,
    Optional<int>? duration,
    Optional<int>? poses,
    Optional<List<StretchingLessonMedia>>? media,
  }) {
    return StretchingLesson(
      completed: completed?.isValid == true ? completed?.value : this.completed,
      opened: opened?.isValid == true ? opened?.value : this.opened,
      id: id?.isValid == true ? id?.value : this.id,
      weekId: weekId?.isValid == true ? weekId?.value : this.weekId,
      order: order?.isValid == true ? order?.value : this.order,
      title: title?.isValid == true ? title?.value : this.title,
      duration: duration?.isValid == true ? duration?.value : this.duration,
      poses: poses?.isValid == true ? poses?.value : this.poses,
      media: media?.isValid == true ? media?.value : this.media,
    );
  }

  factory StretchingLesson.fromMap(Map<String, dynamic> map) {
    return StretchingLesson(
      completed: map['completed'] as bool?,
      opened: map['opened'] as bool?,
      id: map['id'],
      weekId: map['weekId'],
      order: map['order'] as int?,
      title: map['title'],
      duration: map['duration'] as int?,
      poses: map['poses'] as int?,
      media: (map['media'] as List<dynamic>?)?.map((element) => StretchingLessonMedia.fromMap(element)).toList(),
    );
  }

  factory StretchingLesson.fromJson(Map<String, dynamic> json) {
    return _$StretchingLessonFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StretchingLessonToJson(this);
  }
}

@JsonSerializable()
@immutable
class StretchingLessonMedia {
  final String? downloadURL;
  final int? lastModifiedTS;
  final String? name;
  final String? ref;
  final String? type;

  const StretchingLessonMedia({
    required this.downloadURL,
    required this.lastModifiedTS,
    required this.name,
    required this.ref,
    required this.type,
  });

  StretchingLessonMedia copyWith({
    Optional<String>? downloadURL,
    Optional<int>? lastModifiedTS,
    Optional<String>? name,
    Optional<String>? ref,
    Optional<String>? type,
  }) {
    return StretchingLessonMedia(
      downloadURL: downloadURL?.isValid == true ? downloadURL?.value : this.downloadURL,
      lastModifiedTS: lastModifiedTS?.isValid == true ? lastModifiedTS?.value : this.lastModifiedTS,
      name: name?.isValid == true ? name?.value : this.name,
      ref: ref?.isValid == true ? ref?.value : this.ref,
      type: type?.isValid == true ? type?.value : this.type,
    );
  }

  factory StretchingLessonMedia.fromMap(Map<String, dynamic> map) {
    return StretchingLessonMedia(
      downloadURL: map['downloadURL'],
      lastModifiedTS: map['lastModifiedTS'],
      name: map['name'],
      ref: map['ref'],
      type: map['type'],
    );
  }

  factory StretchingLessonMedia.fromJson(Map<String, dynamic> json) {
    return _$StretchingLessonMediaFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StretchingLessonMediaToJson(this);
  }
}
