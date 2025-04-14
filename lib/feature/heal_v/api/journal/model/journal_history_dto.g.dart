// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_history_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JournalHistoryDto _$JournalHistoryDtoFromJson(Map<String, dynamic> json) =>
    JournalHistoryDto(
      message: json['message'] as String?,
      date: json['date'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$JournalHistoryDtoToJson(JournalHistoryDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'date': instance.date,
      'id': instance.id,
    };
