// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_packet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpPacket _$SignUpPacketFromJson(Map<String, dynamic> json) => SignUpPacket(
      email: json['email'] as String?,
      password: json['password'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$SignUpPacketToJson(SignUpPacket instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
    };
