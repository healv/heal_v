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
      category: (json['category'] as List<dynamic>?)
          ?.map(
              (e) => MeditationCategoryDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      photoUrl: (json['photoUrl'] as List<dynamic>?)
          ?.map(
              (e) => MeditationMediaUrlDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      audioUrl: (json['audioUrl'] as List<dynamic>?)
          ?.map(
              (e) => MeditationMediaUrlDto.fromJson(e as Map<String, dynamic>))
          .toList(),
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

MeditationCategoryDto _$MeditationCategoryDtoFromJson(
        Map<String, dynamic> json) =>
    MeditationCategoryDto(
      id: json['id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$MeditationCategoryDtoToJson(
        MeditationCategoryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

MeditationMediaUrlDto _$MeditationMediaUrlDtoFromJson(
        Map<String, dynamic> json) =>
    MeditationMediaUrlDto(
      downloadURL: json['downloadURL'] as String?,
      lastModifiedTS: (json['lastModifiedTS'] as num?)?.toInt(),
      name: json['name'] as String?,
      ref: json['ref'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$MeditationMediaUrlDtoToJson(
        MeditationMediaUrlDto instance) =>
    <String, dynamic>{
      'downloadURL': instance.downloadURL,
      'lastModifiedTS': instance.lastModifiedTS,
      'name': instance.name,
      'ref': instance.ref,
      'type': instance.type,
    };
