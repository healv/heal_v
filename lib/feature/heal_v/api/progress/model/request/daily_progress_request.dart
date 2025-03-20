import 'package:json_annotation/json_annotation.dart';

part 'daily_progress_request.g.dart';

@JsonSerializable()
class DailyProgressRequest {
  @JsonKey(name: "breathing")
  final bool? breathing;
  @JsonKey(name: "meditation")
  final bool? meditation;
  @JsonKey(name: "stretching")
  final bool? stretching;
  @JsonKey(name: "journal")
  final bool? journal;
  @JsonKey(name: "date")
  final String? date;

  DailyProgressRequest ({
    this.breathing,
    this.meditation,
    this.stretching,
    this.journal,
    this.date,
  });

  factory DailyProgressRequest.fromJson(Map<String, dynamic> json) {
    return _$DailyProgressRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DailyProgressRequestToJson(this);
  }
}


