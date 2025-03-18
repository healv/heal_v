import 'package:json_annotation/json_annotation.dart';

part 'shared_content_dto.g.dart';

@JsonSerializable()
class SharedContentDto {
  @JsonKey(name: "appBarMessage")
  final String? appBarMessage;

  SharedContentDto({this.appBarMessage});

  factory SharedContentDto.fromJson(Map<String, dynamic> json) {
    return _$SharedContentDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SharedContentDtoToJson(this);
  }
}
