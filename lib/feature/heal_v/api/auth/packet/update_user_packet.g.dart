// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_packet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserPacket _$UpdateUserPacketFromJson(Map<String, dynamic> json) =>
    UpdateUserPacket(
      name: json['name'] as String?,
      lastName: json['lastName'] as String?,
      birthDate: json['birthDate'] as String?,
    );

Map<String, dynamic> _$UpdateUserPacketToJson(UpdateUserPacket instance) =>
    <String, dynamic>{
      'name': instance.name,
      'lastName': instance.lastName,
      'birthDate': instance.birthDate,
    };
