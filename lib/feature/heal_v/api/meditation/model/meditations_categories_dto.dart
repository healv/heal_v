import 'package:json_annotation/json_annotation.dart';

part 'meditations_categories_dto.g.dart';

@JsonSerializable()
class MeditationsCategoriesDto {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;

  MeditationsCategoriesDto ({
    this.id,
    this.name,
  });

  factory MeditationsCategoriesDto.fromJson(Map<String, dynamic> json) {
    return _$MeditationsCategoriesDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MeditationsCategoriesDtoToJson(this);
  }
}


