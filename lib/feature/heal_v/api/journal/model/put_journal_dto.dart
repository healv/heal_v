import 'package:json_annotation/json_annotation.dart';

part 'put_journal_dto.g.dart';

@JsonSerializable()
class PutJournalDto {
  @JsonKey(name: "code")
  final int? code;
  @JsonKey(name: "status")
  final String? status;

  PutJournalDto({
    this.code,
    this.status,
  });

  factory PutJournalDto.fromJson(Map<String, dynamic> json) {
    return _$PutJournalDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PutJournalDtoToJson(this);
  }
}
