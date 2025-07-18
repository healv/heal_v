import 'package:json_annotation/json_annotation.dart';

part 'meditation_lessons_dto.g.dart';

@JsonSerializable()
class MeditationLessonsDto {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "order")
  final int? order;
  @JsonKey(name: "lessons")
  final List<MeditationLessonDto>? lessons;

  MeditationLessonsDto({
    this.lessons,
    this.id,
    this.title,
    this.order,
  });

  factory MeditationLessonsDto.fromJson(Map<String, dynamic> json) {
    return _$MeditationLessonsDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MeditationLessonsDtoToJson(this);
  }
}

@JsonSerializable()
class MeditationLessonDto {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "order")
  final int? order;
  @JsonKey(name: "poses")
  final int? poses;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "preview")
  final MeditationLessonPreviewDto? preview;
  @JsonKey(name: "media")
  final MeditationLessonMediaDto? media;
  @JsonKey(name: "weekId")
  final String? weekId;
  @JsonKey(name: "isCompleted")
  final bool? isCompleted;
  @JsonKey(name: "isAccessible")
  final bool? isAccessible;
  @JsonKey(name: "hasSubscriptionAccess")
  final bool? hasSubscriptionAccess;
  @JsonKey(name: "requiresSubscription")
  final bool? requiresSubscription;

  MeditationLessonDto({
    this.id,
    this.title,
    this.order,
    this.poses,
    this.description,
    this.preview,
    this.media,
    this.weekId,
    this.isCompleted,
    this.isAccessible,
    this.hasSubscriptionAccess,
    this.requiresSubscription,
  });

  factory MeditationLessonDto.fromJson(Map<String, dynamic> json) {
    return _$MeditationLessonDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MeditationLessonDtoToJson(this);
  }
}

@JsonSerializable()
class MeditationLessonPreviewDto {
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "width")
  final int? width;
  @JsonKey(name: "height")
  final int? height;
  @JsonKey(name: "url")
  final String? url;

  MeditationLessonPreviewDto({
    this.name,
    this.width,
    this.height,
    this.url,
  });

  factory MeditationLessonPreviewDto.fromJson(Map<String, dynamic> json) {
    return _$MeditationLessonPreviewDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MeditationLessonPreviewDtoToJson(this);
  }
}

@JsonSerializable()
class MeditationLessonMediaDto {
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "ext")
  final String? ext;
  @JsonKey(name: "url")
  final String? url;

  MeditationLessonMediaDto({
    this.name,
    this.ext,
    this.url,
  });

  factory MeditationLessonMediaDto.fromJson(Map<String, dynamic> json) {
    return _$MeditationLessonMediaDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MeditationLessonMediaDtoToJson(this);
  }
}
