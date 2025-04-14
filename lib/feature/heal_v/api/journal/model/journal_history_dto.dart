import 'package:json_annotation/json_annotation.dart';

part 'journal_history_dto.g.dart';

@JsonSerializable()
class JournalHistoryDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "date")
  final String? date;
  @JsonKey(name: "id")
  final String? id;

  JournalHistoryDto ({
    this.message,
    this.date,
    this.id,
  });

  factory JournalHistoryDto.fromJson(Map<String, dynamic> json) {
    return _$JournalHistoryDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$JournalHistoryDtoToJson(this);
  }
}


