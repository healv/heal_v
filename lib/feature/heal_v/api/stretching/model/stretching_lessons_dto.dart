import 'package:json_annotation/json_annotation.dart';

part 'stretching_lessons_dto.g.dart';

@JsonSerializable()
class StretchingLessonsDto {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "order")
  final int? order;
  @JsonKey(name: "lessons")
  final List<StretchingLessonDto>? lessons;

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
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "order")
  final int? order;
  @JsonKey(name: "poses")
  final int? poses;
  @JsonKey(name: "duration")
  final int? duration;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "preview")
  final StretchingLessonPreviewDto? preview;
  @JsonKey(name: "media")
  final StretchingLessonMediaDto? media;
  @JsonKey(name: "isCompleted")
  final bool? isCompleted;
  @JsonKey(name: "isAccessible")
  final bool? isAccessible;

  StretchingLessonDto({
    this.id,
    this.title,
    this.order,
    this.poses,
    this.duration,
    this.description,
    this.preview,
    this.media,
    this.isCompleted,
    this.isAccessible,
  });

  factory StretchingLessonDto.fromJson(Map<String, dynamic> json) {
    return _$StretchingLessonDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StretchingLessonDtoToJson(this);
  }
}

@JsonSerializable()
class StretchingLessonPreviewDto {
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "width")
  final int? width;
  @JsonKey(name: "height")
  final int? height;
  @JsonKey(name: "url")
  final String? url;

  StretchingLessonPreviewDto({
    this.name,
    this.width,
    this.height,
    this.url,
  });

  factory StretchingLessonPreviewDto.fromJson(Map<String, dynamic> json) {
    return _$StretchingLessonPreviewDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StretchingLessonPreviewDtoToJson(this);
  }
}

@JsonSerializable()
class StretchingLessonMediaDto {
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "ext")
  final String? ext;
  @JsonKey(name: "url")
  final String? url;

  StretchingLessonMediaDto({
    this.name,
    this.ext,
    this.url,
  });

  factory StretchingLessonMediaDto.fromJson(Map<String, dynamic> json) {
    return _$StretchingLessonMediaDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StretchingLessonMediaDtoToJson(this);
  }
}
