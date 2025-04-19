// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_firebase_packet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginFirebasePacket _$LoginFirebasePacketFromJson(Map<String, dynamic> json) =>
    LoginFirebasePacket(
      uid: json['uid'] as String?,
      email: json['email'] as String?,
      displayName: json['displayName'] as String?,
    );

Map<String, dynamic> _$LoginFirebasePacketToJson(
        LoginFirebasePacket instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'displayName': instance.displayName,
    };
