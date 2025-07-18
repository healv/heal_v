import 'package:flutter/foundation.dart';
import 'package:heal_v/feature/heal_v/api/stretching/model/stretching_lessons_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../common/dart/optional.dart';

part 'stretching_lessons_ui_model.g.dart';

@JsonSerializable()
@immutable
class StretchingLessons {
  final String? id;
  final String? title;
  final int? order;
  final List<StretchingLesson>? lessons;

  const StretchingLessons({
    required this.id,
    required this.title,
    required this.order,
    required this.lessons,
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
}

@JsonSerializable()
@immutable
class StretchingLesson {
  final String? id;
  final String? title;
  final int? order;
  final int? poses;
  final String? description;
  final StretchingLessonPreview? preview;
  final StretchingLessonMedia? media;
  final String? weekId;
  final bool? isCompleted;
  final bool? isAccessible;
  final int? duration;
  final bool? hasSubscriptionAccess;
  final bool? requiresSubscription;

  const StretchingLesson({
    required this.id,
    required this.title,
    required this.poses,
    required this.order,
    required this.description,
    required this.preview,
    required this.media,
    required this.weekId,
    required this.isCompleted,
    required this.isAccessible,
    required this.duration,
    required this.hasSubscriptionAccess,
    required this.requiresSubscription,
  });

  StretchingLesson copyWith({
    Optional<String>? id,
    Optional<String>? title,
    Optional<int>? order,
    Optional<int>? poses,
    Optional<String?>? description,
    Optional<StretchingLessonPreview?>? preview,
    Optional<StretchingLessonMedia?>? media,
    Optional<String>? weekId,
    Optional<bool>? isCompleted,
    Optional<bool>? isAccessible,
    Optional<int>? duration,
    Optional<bool>? hasSubscriptionAccess,
    Optional<bool>? requiresSubscription,
  }) {
    return StretchingLesson(
      isCompleted: isCompleted?.isValid == true ? isCompleted?.value : this.isCompleted,
      isAccessible: isAccessible?.isValid == true ? isAccessible?.value : this.isAccessible,
      id: id?.isValid == true ? id?.value : this.id,
      order: order?.isValid == true ? order?.value : this.order,
      title: title?.isValid == true ? title?.value : this.title,
      duration: duration?.isValid == true ? duration?.value : this.duration,
      poses: poses?.isValid == true ? poses?.value : this.poses,
      media: media?.isValid == true ? media?.value : this.media,
      preview: preview?.isValid == true ? preview?.value : this.preview,
      description: description?.isValid == true ? description?.value : this.description,
      weekId: weekId?.isValid == true ? weekId?.value : this.weekId,
      hasSubscriptionAccess: hasSubscriptionAccess?.isValid == true ? hasSubscriptionAccess?.value : this.hasSubscriptionAccess,
      requiresSubscription: requiresSubscription?.isValid == true ? requiresSubscription?.value : this.requiresSubscription,
    );
  }

  factory StretchingLesson.fromMap(Map<String, dynamic> map) {
    return StretchingLesson(
      id: map['id'],
      title: map['title'],
      order: map['order'] as int?,
      poses: map['poses'] as int?,
      description: map['description'] as String?,
      preview: StretchingLessonPreview.fromMap((map['preview'] as StretchingLessonPreviewDto?)?.toJson() ?? {}),
      media: StretchingLessonMedia.fromMap((map['media'] as StretchingLessonMediaDto?)?.toJson() ?? {}),
      weekId: map['weekId'] as String?,
      isCompleted: map['isCompleted'] as bool?,
      isAccessible: map['isAccessible'] as bool?,
      hasSubscriptionAccess: map['hasSubscriptionAccess'] as bool?,
      requiresSubscription: map['requiresSubscription'] as bool?,
      duration: map['duration'] as int?,
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
class StretchingLessonPreview {
  final String? name;
  final int? width;
  final int? height;
  final String? url;

  const StretchingLessonPreview({
    required this.name,
    required this.width,
    required this.height,
    required this.url,
  });

  StretchingLessonPreview copyWith({
    Optional<String>? name,
    Optional<int>? width,
    Optional<int>? height,
    Optional<String>? url,
  }) {
    return StretchingLessonPreview(
      name: name?.isValid == true ? name?.value : this.name,
      width: width?.isValid == true ? width?.value : this.width,
      height: height?.isValid == true ? height?.value : this.height,
      url: url?.isValid == true ? url?.value : this.url,
    );
  }

  factory StretchingLessonPreview.fromMap(Map<String, dynamic> map) {
    return StretchingLessonPreview(
      name: map['name'],
      width: map['width'] as int?,
      height: map['height'] as int?,
      url: map['url'],
    );
  }

  factory StretchingLessonPreview.fromJson(Map<String, dynamic> json) {
    return _$StretchingLessonPreviewFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StretchingLessonPreviewToJson(this);
  }
}

@JsonSerializable()
@immutable
class StretchingLessonMedia {
  final String? name;
  final String? ext;
  final String? url;

  const StretchingLessonMedia({
    required this.name,
    required this.ext,
    required this.url,
  });

  StretchingLessonMedia copyWith({
    Optional<String?>? name,
    Optional<String?>? ext,
    Optional<String?>? url,
  }) {
    return StretchingLessonMedia(
      name: name?.isValid == true ? name?.value : this.name,
      ext: ext?.isValid == true ? ext?.value : this.ext,
      url: url?.isValid == true ? url?.value : this.url,
    );
  }

  factory StretchingLessonMedia.fromMap(Map<String, dynamic> map) {
    return StretchingLessonMedia(
      name: map['name'],
      ext: map['ext'],
      url: map['url'],
    );
  }

  factory StretchingLessonMedia.fromJson(Map<String, dynamic> json) {
    return _$StretchingLessonMediaFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StretchingLessonMediaToJson(this);
  }
}
