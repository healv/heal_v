import 'package:json_annotation/json_annotation.dart';

part 'breathing_lessons_dto.g.dart';

@JsonSerializable()
class BreathingLessonsDto {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "order")
  final int? order;
  @JsonKey(name: "lessons")
  final List<BreathingLessonDto>? lessons;

  BreathingLessonsDto({
    this.lessons,
    this.id,
    this.title,
    this.order,
  });

  factory BreathingLessonsDto.fromJson(Map<String, dynamic> json) {
    return _$BreathingLessonsDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BreathingLessonsDtoToJson(this);
  }
}

@JsonSerializable()
class BreathingLessonDto {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "order")
  final int? order;
  @JsonKey(name: "duration")
  final int? duration;
  @JsonKey(name: "shortDescription")
  final String? shortDescription;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "preview")
  final BreathingLessonPreviewDto? preview;
  @JsonKey(name: "media")
  final BreathingLessonMediaDto? media;
  @JsonKey(name: "isCompleted")
  final bool? isCompleted;
  @JsonKey(name: "isAccessible")
  final bool? isAccessible;

  BreathingLessonDto({
    this.id,
    this.title,
    this.order,
    this.duration,
    this.shortDescription,
    this.description,
    this.preview,
    this.media,
    this.isCompleted,
    this.isAccessible,
  });

  factory BreathingLessonDto.fromJson(Map<String, dynamic> json) {
    return _$BreathingLessonDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BreathingLessonDtoToJson(this);
  }
}

@JsonSerializable()
class BreathingLessonPreviewDto {
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "width")
  final int? width;
  @JsonKey(name: "height")
  final int? height;
  @JsonKey(name: "url")
  final String? url;

  BreathingLessonPreviewDto({
    this.name,
    this.width,
    this.height,
    this.url,
  });

  factory BreathingLessonPreviewDto.fromJson(Map<String, dynamic> json) {
    return _$BreathingLessonPreviewDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BreathingLessonPreviewDtoToJson(this);
  }
}

@JsonSerializable()
class BreathingLessonMediaDto {
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "ext")
  final String? ext;
  @JsonKey(name: "url")
  final String? url;

  BreathingLessonMediaDto({
    this.name,
    this.ext,
    this.url,
  });

  factory BreathingLessonMediaDto.fromJson(Map<String, dynamic> json) {
    return _$BreathingLessonMediaDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BreathingLessonMediaDtoToJson(this);
  }
}
