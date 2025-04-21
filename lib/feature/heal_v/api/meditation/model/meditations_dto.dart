import 'package:json_annotation/json_annotation.dart';

part 'meditations_dto.g.dart';

@JsonSerializable()
class MeditationsDto {
  @JsonKey(name: "meditations")
  final List<MeditationDto>? meditations;
  @JsonKey(name: "nextCursor")
  final dynamic nextCursor;
  @JsonKey(name: "prevCursor")
  final String? prevCursor;

  MeditationsDto({
    this.meditations,
    this.nextCursor,
    this.prevCursor,
  });

  factory MeditationsDto.fromJson(Map<String, dynamic> json) {
    return _$MeditationsDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MeditationsDtoToJson(this);
  }
}

@JsonSerializable()
class MeditationDto {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "author")
  final String? author;
  @JsonKey(name: "category")
  final List<MeditationCategoryDto>? category;
  @JsonKey(name: "photoUrl")
  final List<MeditationMediaUrlDto>? photoUrl;
  @JsonKey(name: "audioUrl")
  final List<MeditationMediaUrlDto>? audioUrl;

  MeditationDto({
    this.id,
    this.name,
    this.author,
    this.category,
    this.photoUrl,
    this.audioUrl,
  });

  factory MeditationDto.fromJson(Map<String, dynamic> json) {
    return _$MeditationDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MeditationDtoToJson(this);
  }
}

@JsonSerializable()
class MeditationCategoryDto {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;

  MeditationCategoryDto({
    this.id,
    this.name,
  });

  factory MeditationCategoryDto.fromJson(Map<String, dynamic> json) {
    return _$MeditationCategoryDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MeditationCategoryDtoToJson(this);
  }
}

@JsonSerializable()
class MeditationMediaUrlDto {
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

  MeditationMediaUrlDto({
    required this.downloadURL,
    required this.lastModifiedTS,
    required this.name,
    required this.ref,
    required this.type,
  });

  factory MeditationMediaUrlDto.fromJson(Map<String, dynamic> json) {
    return _$MeditationMediaUrlDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MeditationMediaUrlDtoToJson(this);
  }
}
