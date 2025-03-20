import 'package:heal_v/common/dart/packet.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_up_packet.g.dart';

@JsonSerializable()
final class SignUpPacket extends Packet {
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "password")
  final String? password;
  @JsonKey(name: "name")
  final String? name;

  SignUpPacket({
    this.email,
    this.password,
    this.name,
  });

  factory SignUpPacket.fromJson(Map<String, dynamic> json) {
    return _$SignUpPacketFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SignUpPacketToJson(this);
  }
}
