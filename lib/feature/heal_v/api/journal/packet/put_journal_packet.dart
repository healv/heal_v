import 'package:json_annotation/json_annotation.dart';

import '../../../../../common/dart/packet.dart';

part 'put_journal_packet.g.dart';

@JsonSerializable()
final class PutJournalPacket extends Packet {
  @JsonKey(name: "message")
  final String? message;

  PutJournalPacket({
    required this.message,
  });

  factory PutJournalPacket.fromJson(Map<String, dynamic> json) {
    return _$PutJournalPacketFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$PutJournalPacketToJson(this);
  }
}
