// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_progress_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyProgressListDto _$DailyProgressListDtoFromJson(
        Map<String, dynamic> json) =>
    DailyProgressListDto(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DailyProgressDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : PaginationDto.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DailyProgressListDtoToJson(
        DailyProgressListDto instance) =>
    <String, dynamic>{
      'data': instance.data,
      'pagination': instance.pagination,
    };

PaginationDto _$PaginationDtoFromJson(Map<String, dynamic> json) =>
    PaginationDto(
      page: (json['page'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
      pageCount: (json['pageCount'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaginationDtoToJson(PaginationDto instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'pageCount': instance.pageCount,
      'total': instance.total,
    };
