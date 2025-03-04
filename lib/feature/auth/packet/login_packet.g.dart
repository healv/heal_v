// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_packet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginPacket _$LoginPacketFromJson(Map<String, dynamic> json) => LoginPacket(
      email: json['email'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$LoginPacketToJson(LoginPacket instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
