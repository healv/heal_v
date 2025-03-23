import 'package:json_annotation/json_annotation.dart';

part 'breathings_categories_dto.g.dart';

@JsonSerializable()
class BreathingsCategoriesDto {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;

  BreathingsCategoriesDto ({
    this.id,
    this.name,
  });

  factory BreathingsCategoriesDto.fromJson(Map<String, dynamic> json) {
    return _$BreathingsCategoriesDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BreathingsCategoriesDtoToJson(this);
  }
}


