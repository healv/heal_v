// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'put_journal_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PutJournalDto _$PutJournalDtoFromJson(Map<String, dynamic> json) =>
    PutJournalDto(
      code: (json['code'] as num?)?.toInt(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$PutJournalDtoToJson(PutJournalDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
    };
