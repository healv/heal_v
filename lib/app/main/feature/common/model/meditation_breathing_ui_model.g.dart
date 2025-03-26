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
      category: json['category'] as String?,
      photoUrl: json['photoUrl'] as String?,
      audioUrl: json['audioUrl'] as String?,
      description: json['description'] as String?,
      duration: json['duration'] as String?,
      preview: json['preview'] as String?,
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
    };
