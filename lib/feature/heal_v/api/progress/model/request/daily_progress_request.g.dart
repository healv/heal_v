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
      journal: json['journal'] as String?,
    );

Map<String, dynamic> _$DailyProgressRequestToJson(
        DailyProgressRequest instance) =>
    <String, dynamic>{
      if (instance.breathing case final value?) 'breathing': value,
      if (instance.meditation case final value?) 'meditation': value,
      if (instance.stretching case final value?) 'stretching': value,
      if (instance.journal case final value?) 'journal': value,
    };
