import 'package:json_annotation/json_annotation.dart';

import 'breathings_categories_dto.dart';

part 'breathings_dto.g.dart';

@JsonSerializable()
class BreathingsDto {
  @JsonKey(name: "breathings")
  final List<BreathingDto>? breathings;
  @JsonKey(name: "nextCursor")
  final dynamic nextCursor;
  @JsonKey(name: "prevCursor")
  final String? prevCursor;

  BreathingsDto({
    this.breathings,
    this.nextCursor,
    this.prevCursor,
  });

  factory BreathingsDto.fromJson(Map<String, dynamic> json) {
    return _$BreathingsDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BreathingsDtoToJson(this);
  }
}

@JsonSerializable()
class BreathingDto {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "author")
  final String? author;
  @JsonKey(name: "category")
  final List<BreathingsCategoriesDto>? category;
  @JsonKey(name: "duration")
  final String? duration;
  @JsonKey(name: "photoUrl")
  final List<BreathingMediaUrlDto>? photoUrl;
  @JsonKey(name: "preview")
  final String? preview;
  @JsonKey(name: "audioUrl")
  final List<BreathingMediaUrlDto>? audioUrl;

  BreathingDto({
    this.id,
    this.name,
    this.author,
    this.category,
    this.photoUrl,
    this.audioUrl,
    this.description,
    this.duration,
    this.preview,
  });

  factory BreathingDto.fromJson(Map<String, dynamic> json) {
    return _$BreathingDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BreathingDtoToJson(this);
  }
}

@JsonSerializable()
class BreathingMediaUrlDto {
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

  BreathingMediaUrlDto({
    required this.downloadURL,
    required this.lastModifiedTS,
    required this.name,
    required this.ref,
    required this.type,
  });

  factory BreathingMediaUrlDto.fromJson(Map<String, dynamic> json) {
    return _$BreathingMediaUrlDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BreathingMediaUrlDtoToJson(this);
  }
}
