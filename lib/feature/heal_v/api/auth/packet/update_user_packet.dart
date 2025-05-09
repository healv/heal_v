import 'package:json_annotation/json_annotation.dart';

import '../../../../../common/dart/packet.dart';

part 'update_user_packet.g.dart';

@JsonSerializable()
final class UpdateUserPacket extends Packet {
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "birthDate")
  final String? birthDate;

  UpdateUserPacket({
    required this.name,
    required this.lastName,
    required this.birthDate,
  });

  factory UpdateUserPacket.fromJson(Map<String, dynamic> json) {
    return _$UpdateUserPacketFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$UpdateUserPacketToJson(this);
  }
}
