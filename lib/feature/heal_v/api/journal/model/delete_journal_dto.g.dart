// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_journal_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteJournalDto _$DeleteJournalDtoFromJson(Map<String, dynamic> json) =>
    DeleteJournalDto(
      code: (json['code'] as num?)?.toInt(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$DeleteJournalDtoToJson(DeleteJournalDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
    };
