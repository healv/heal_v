// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_progress_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyProgressRequest _$DailyProgressRequestFromJson(
        Map<String, dynamic> json) =>
    DailyProgressRequest(
      breathing: json['breathing'] as bool?,
      meditation: json['meditation'] as bool?,
      stretching: json['stretching'] as bool?,
      journal: json['journal'] as bool?,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$DailyProgressRequestToJson(
        DailyProgressRequest instance) =>
    <String, dynamic>{
      'breathing': instance.breathing,
      'meditation': instance.meditation,
      'stretching': instance.stretching,
      'journal': instance.journal,
      'date': instance.date,
    };
