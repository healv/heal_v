// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meditation_breathing_ui_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeditationBreathing _$MeditationBreathingFromJson(Map<String, dynamic> json) =>
    MeditationBreathing(
      id: json['id'] as String?,
      name: json['name'] as String?,
      author: json['author'] as String?,
      category: (json['category'] as List<dynamic>?)
          ?.map((e) =>
              MeditationBreathingCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      photoUrl: (json['photoUrl'] as List<dynamic>?)
          ?.map((e) =>
              MeditationBreathingMediaUrl.fromJson(e as Map<String, dynamic>))
          .toList(),
      audioUrl: (json['audioUrl'] as List<dynamic>?)
          ?.map((e) =>
              MeditationBreathingMediaUrl.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
      duration: json['duration'] as String?,
      preview: json['preview'] as String?,
      showDescription: json['showDescription'] as bool?,
      isEnable: json['isEnable'] as bool?,
      type: $enumDecodeNullable(_$MeditationTypeEnumEnumMap, json['type']),
      demoImage: json['demoImage'] as String?,
    );

Map<String, dynamic> _$MeditationBreathingToJson(
        MeditationBreathing instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'author': instance.author,
      'category': instance.category,
      'photoUrl': instance.photoUrl,
      'audioUrl': instance.audioUrl,
      'description': instance.description,
      'duration': instance.duration,
      'preview': instance.preview,
      'showDescription': instance.showDescription,
      'isEnable': instance.isEnable,
      'type': _$MeditationTypeEnumEnumMap[instance.type],
      'demoImage': instance.demoImage,
    };

const _$MeditationTypeEnumEnumMap = {
  MeditationTypeEnum.meditations: 'meditations',
  MeditationTypeEnum.breathings: 'breathings',
};

MeditationBreathingCategory _$MeditationBreathingCategoryFromJson(
        Map<String, dynamic> json) =>
    MeditationBreathingCategory(
      id: json['id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$MeditationBreathingCategoryToJson(
        MeditationBreathingCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

MeditationBreathingMediaUrl _$MeditationBreathingMediaUrlFromJson(
        Map<String, dynamic> json) =>
    MeditationBreathingMediaUrl(
      downloadURL: json['downloadURL'] as String?,
      lastModifiedTS: (json['lastModifiedTS'] as num?)?.toInt(),
      name: json['name'] as String?,
      ref: json['ref'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$MeditationBreathingMediaUrlToJson(
        MeditationBreathingMediaUrl instance) =>
    <String, dynamic>{
      'downloadURL': instance.downloadURL,
      'lastModifiedTS': instance.lastModifiedTS,
      'name': instance.name,
      'ref': instance.ref,
      'type': instance.type,
    };
