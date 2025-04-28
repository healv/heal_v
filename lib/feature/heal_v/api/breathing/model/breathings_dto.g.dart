// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breathings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BreathingsDto _$BreathingsDtoFromJson(Map<String, dynamic> json) =>
    BreathingsDto(
      breathings: (json['breathings'] as List<dynamic>?)
          ?.map((e) => BreathingDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextCursor: json['nextCursor'],
      prevCursor: json['prevCursor'] as String?,
    );

Map<String, dynamic> _$BreathingsDtoToJson(BreathingsDto instance) =>
    <String, dynamic>{
      'breathings': instance.breathings,
      'nextCursor': instance.nextCursor,
      'prevCursor': instance.prevCursor,
    };

BreathingDto _$BreathingDtoFromJson(Map<String, dynamic> json) => BreathingDto(
      id: json['id'] as String?,
      name: json['name'] as String?,
      author: json['author'] as String?,
      category: (json['category'] as List<dynamic>?)
          ?.map((e) =>
              BreathingsCategoriesDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      photoUrl: (json['photoUrl'] as List<dynamic>?)
          ?.map((e) => BreathingMediaUrlDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      audioUrl: (json['audioUrl'] as List<dynamic>?)
          ?.map((e) => BreathingMediaUrlDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
      duration: json['duration'] as String?,
      preview: json['preview'] as String?,
    );

Map<String, dynamic> _$BreathingDtoToJson(BreathingDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'author': instance.author,
      'category': instance.category,
      'duration': instance.duration,
      'photoUrl': instance.photoUrl,
      'preview': instance.preview,
      'audioUrl': instance.audioUrl,
    };

BreathingMediaUrlDto _$BreathingMediaUrlDtoFromJson(
        Map<String, dynamic> json) =>
    BreathingMediaUrlDto(
      downloadURL: json['downloadURL'] as String?,
      lastModifiedTS: (json['lastModifiedTS'] as num?)?.toInt(),
      name: json['name'] as String?,
      ref: json['ref'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$BreathingMediaUrlDtoToJson(
        BreathingMediaUrlDto instance) =>
    <String, dynamic>{
      'downloadURL': instance.downloadURL,
      'lastModifiedTS': instance.lastModifiedTS,
      'name': instance.name,
      'ref': instance.ref,
      'type': instance.type,
    };
