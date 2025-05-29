import 'package:heal_v/feature/heal_v/api/progress/model/response/daily_progress_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'daily_progress_list_dto.g.dart';

@JsonSerializable()
class DailyProgressListDto {
  @JsonKey(name: 'data')
  final List<DailyProgressDto>? data;
  @JsonKey(name: 'pagination')
  final PaginationDto? pagination;

  DailyProgressListDto({
    required this.data,
    required this.pagination,
  });

  factory DailyProgressListDto.fromJson(Map<String, dynamic> json) {
    return _$DailyProgressListDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DailyProgressListDtoToJson(this);
  }
}

@JsonSerializable()
class PaginationDto {
  @JsonKey(name: 'page')
  final int? page;
  @JsonKey(name: 'pageSize')
  final int? pageSize;
  @JsonKey(name: 'pageCount')
  final int? pageCount;
  @JsonKey(name: 'total')
  final int? total;

  PaginationDto({
    required this.page,
    required this.pageSize,
    required this.pageCount,
    required this.total,
  });

  factory PaginationDto.fromJson(Map<String, dynamic> json) {
    return _$PaginationDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PaginationDtoToJson(this);
  }
}
