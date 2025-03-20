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

  MeditationsDto ({
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
  final String? category;
  @JsonKey(name: "photoUrl")
  final String? photoUrl;
  @JsonKey(name: "audioUrl")
  final String? audioUrl;

  MeditationDto ({
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


