import 'package:heal_v/common/dart/packet.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_packet.g.dart';

@JsonSerializable()
final class LoginPacket extends Packet {
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "password")
  final String? password;

  LoginPacket({
    this.email,
    this.password,
  });

  factory LoginPacket.fromJson(Map<String, dynamic> json) {
    return _$LoginPacketFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$LoginPacketToJson(this);
  }
}
