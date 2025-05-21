import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../common/dart/optional.dart';
import '../../../../../feature/heal_v/api/meditation/model/meditation_lessons_dto.dart';

part 'meditation_lessons_ui_model.g.dart';

@JsonSerializable()
@immutable
class MeditationLessons {
  final List<MeditationLesson>? lessons;
  final String? id;
  final String? title;
  final int? order;

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

  bool isAllLessonsCompleted() => lessons?.every((item) => item.completed == true) == true;
}

@JsonSerializable()
@immutable
class MeditationLesson {
  final bool? completed;
  final bool? opened;
  final String? id;
  final String? weekId;
  final int? order;
  final String? title;
  final int? duration;
  final int? poses;
  final List<MeditationLessonMedia>? media;

  const MeditationLesson({
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

  MeditationLesson copyWith({
    Optional<bool>? completed,
    Optional<bool>? opened,
    Optional<String>? id,
    Optional<String>? weekId,
    Optional<int>? order,
    Optional<String>? title,
    Optional<int>? duration,
    Optional<int>? poses,
    Optional<List<MeditationLessonMedia>>? media,
  }) {
    return MeditationLesson(
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

  factory MeditationLesson.fromMap(Map<String, dynamic> map) {
    return MeditationLesson(
      completed: map['completed'] as bool?,
      opened: map['opened'] as bool?,
      id: map['id'],
      weekId: map['weekId'],
      order: map['order'] as int?,
      title: map['title'],
      duration: map['duration'] as int?,
      poses: map['poses'] as int?,
      media: (map['media'] as List<dynamic>?)?.map((element) => MeditationLessonMedia.fromMap(element)).toList(),
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
class MeditationLessonMedia {
  final String? downloadURL;
  final int? lastModifiedTS;
  final String? name;
  final String? ref;
  final String? type;

  const MeditationLessonMedia({
    required this.downloadURL,
    required this.lastModifiedTS,
    required this.name,
    required this.ref,
    required this.type,
  });

  MeditationLessonMedia copyWith({
    Optional<String>? downloadURL,
    Optional<int>? lastModifiedTS,
    Optional<String>? name,
    Optional<String>? ref,
    Optional<String>? type,
  }) {
    return MeditationLessonMedia(
      downloadURL: downloadURL?.isValid == true ? downloadURL?.value : this.downloadURL,
      lastModifiedTS: lastModifiedTS?.isValid == true ? lastModifiedTS?.value : this.lastModifiedTS,
      name: name?.isValid == true ? name?.value : this.name,
      ref: ref?.isValid == true ? ref?.value : this.ref,
      type: type?.isValid == true ? type?.value : this.type,
    );
  }

  factory MeditationLessonMedia.fromMap(Map<String, dynamic> map) {
    return MeditationLessonMedia(
      downloadURL: map['downloadURL'],
      lastModifiedTS: map['lastModifiedTS'],
      name: map['name'],
      ref: map['ref'],
      type: map['type'],
    );
  }

  factory MeditationLessonMedia.fromJson(Map<String, dynamic> json) {
    return _$MeditationLessonMediaFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MeditationLessonMediaToJson(this);
  }
}
