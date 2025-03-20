import 'package:json_annotation/json_annotation.dart';

part 'breathings_dto.g.dart';

@JsonSerializable()
class BreathingsDto {
  @JsonKey(name: "breathings")
  final List<BreathingDto>? breathings;
  @JsonKey(name: "nextCursor")
  final dynamic nextCursor;
  @JsonKey(name: "prevCursor")
  final String? prevCursor;

  BreathingsDto ({
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
  @JsonKey(name: "author")
  final String? author;
  @JsonKey(name: "category")
  final String? category;
  @JsonKey(name: "photoUrl")
  final String? photoUrl;
  @JsonKey(name: "audioUrl")
  final String? audioUrl;

  BreathingDto ({
    this.id,
    this.name,
    this.author,
    this.category,
    this.photoUrl,
    this.audioUrl,
  });

  factory BreathingDto.fromJson(Map<String, dynamic> json) {
    return _$BreathingDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BreathingDtoToJson(this);
  }
}


