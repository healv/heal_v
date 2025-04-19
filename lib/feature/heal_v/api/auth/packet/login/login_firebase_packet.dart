import 'package:json_annotation/json_annotation.dart';

import '../../../../../../common/dart/packet.dart';

part 'login_firebase_packet.g.dart';

@JsonSerializable()
final class LoginFirebasePacket extends Packet {
  @JsonKey(name: "uid")
  final String? uid;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "displayName")
  final String? displayName;

  LoginFirebasePacket({
    this.uid,
    this.email,
    this.displayName,
  });

  factory LoginFirebasePacket.fromJson(Map<String, dynamic> json) {
    return _$LoginFirebasePacketFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$LoginFirebasePacketToJson(this);
  }
}
