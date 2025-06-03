// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total_progress_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TotalProgressDto _$TotalProgressDtoFromJson(Map<String, dynamic> json) =>
    TotalProgressDto(
      meditation: (json['meditation'] as num?)?.toInt(),
      stretching: (json['stretching'] as num?)?.toInt(),
      breathing: (json['breathing'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TotalProgressDtoToJson(TotalProgressDto instance) =>
    <String, dynamic>{
      'meditation': instance.meditation,
      'stretching': instance.stretching,
      'breathing': instance.breathing,
    };
