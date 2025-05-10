import 'package:json_annotation/json_annotation.dart';

part 'delete_journal_dto.g.dart';

@JsonSerializable()
class DeleteJournalDto {
  @JsonKey(name: "code")
  final int? code;
  @JsonKey(name: "status")
  final String? status;

  DeleteJournalDto({
    this.code,
    this.status,
  });

  factory DeleteJournalDto.fromJson(Map<String, dynamic> json) {
    return _$DeleteJournalDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DeleteJournalDtoToJson(this);
  }
}
