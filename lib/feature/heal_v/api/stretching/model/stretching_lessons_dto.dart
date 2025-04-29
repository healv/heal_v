import 'package:json_annotation/json_annotation.dart';

part 'stretching_lessons_dto.g.dart';

@JsonSerializable()
class StretchingLessonsDto {
  @JsonKey(name: "lessons")
  final List<StretchingLessonDto>? lessons;
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "order")
  final int? order;

  StretchingLessonsDto({
    this.lessons,
    this.id,
    this.title,
    this.order,
  });

  factory StretchingLessonsDto.fromJson(Map<String, dynamic> json) {
    return _$StretchingLessonsDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StretchingLessonsDtoToJson(this);
  }
}

@JsonSerializable()
class StretchingLessonDto {
  @JsonKey(name: "completed")
  final bool? completed;
  @JsonKey(name: "opened")
  final bool? opened;
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "weekId")
  final String? weekId;
  @JsonKey(name: "order")
  final int? order;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "duration")
  final String? duration;
  @JsonKey(name: "poses")
  final int? poses;
  @JsonKey(name: "media")
  final List<StretchingLessonMediaDto>? media;

  StretchingLessonDto({
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

  factory StretchingLessonDto.fromJson(Map<String, dynamic> json) {
    return _$StretchingLessonDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StretchingLessonDtoToJson(this);
  }
}

@JsonSerializable()
class StretchingLessonMediaDto {
  @JsonKey(name: "downloadURL")
  final String? downloadURL;
  @JsonKey(name: "lastModifiedTS")
  final int? lastModifiedTS;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "ref")
  final String? ref;
  @JsonKey(name: "type")
  final String? type;

  StretchingLessonMediaDto({
    required this.downloadURL,
    required this.lastModifiedTS,
    required this.name,
    required this.ref,
    required this.type,
  });

  factory StretchingLessonMediaDto.fromJson(Map<String, dynamic> json) {
    return _$StretchingLessonMediaDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StretchingLessonMediaDtoToJson(this);
  }
}
