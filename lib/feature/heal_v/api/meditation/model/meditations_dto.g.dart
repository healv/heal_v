// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meditations_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeditationsDto _$MeditationsDtoFromJson(Map<String, dynamic> json) =>
    MeditationsDto(
      meditations: (json['meditations'] as List<dynamic>?)
          ?.map((e) => MeditationDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextCursor: json['nextCursor'],
      prevCursor: json['prevCursor'] as String?,
    );

Map<String, dynamic> _$MeditationsDtoToJson(MeditationsDto instance) =>
    <String, dynamic>{
      'meditations': instance.meditations,
      'nextCursor': instance.nextCursor,
      'prevCursor': instance.prevCursor,
    };

MeditationDto _$MeditationDtoFromJson(Map<String, dynamic> json) =>
    MeditationDto(
      id: json['id'] as String?,
      name: json['name'] as String?,
      author: json['author'] as String?,
      category: json['category'] as String?,
      photoUrl: json['photoUrl'] as String?,
      audioUrl: json['audioUrl'] as String?,
    );

Map<String, dynamic> _$MeditationDtoToJson(MeditationDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'author': instance.author,
      'category': instance.category,
      'photoUrl': instance.photoUrl,
      'audioUrl': instance.audioUrl,
    };
