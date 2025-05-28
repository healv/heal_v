// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree_growth_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreeGrowthDto _$TreeGrowthDtoFromJson(Map<String, dynamic> json) =>
    TreeGrowthDto(
      progress: (json['progress'] as num?)?.toInt(),
      idealDayCount: (json['idealDayCount'] as num?)?.toInt(),
      phase: (json['phase'] as num?)?.toInt(),
      dates:
          (json['dates'] as List<dynamic>?)?.map((e) => e as String).toList(),
      datesCount: (json['datesCount'] as num?)?.toInt(),
      idealDays: (json['idealDays'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      idealDaysCount: (json['idealDaysCount'] as num?)?.toInt(),
      missedDays: (json['missedDays'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      missedDaysCount: (json['missedDaysCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TreeGrowthDtoToJson(TreeGrowthDto instance) =>
    <String, dynamic>{
      'progress': instance.progress,
      'idealDayCount': instance.idealDayCount,
      'phase': instance.phase,
      'dates': instance.dates,
      'datesCount': instance.datesCount,
      'idealDays': instance.idealDays,
      'idealDaysCount': instance.idealDaysCount,
      'missedDays': instance.missedDays,
      'missedDaysCount': instance.missedDaysCount,
    };
