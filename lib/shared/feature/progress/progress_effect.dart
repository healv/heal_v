import 'package:heal_v/feature/heal_v/api/progress/model/response/daily_progress_dto.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/daily_progress_list_dto.dart';

import '../../../common/bloc/side_effect/side_effect.dart';
import '../../../common/utils/resource.dart';

sealed class ProgressEffect implements SideEffect {
  final ResourceStatusEnum status;
  final String? errorMsg;

  ProgressEffect(this.status, {this.errorMsg});

  factory ProgressEffect.progressUpdated(
    ResourceStatusEnum status, {
    String? errorMsg,
    String? date,
    DailyProgressDto? dailyProgressDto,
  }) =>
      ProgressUpdated._(status, errorMsg: errorMsg, date: date, dailyProgressDto: dailyProgressDto);

  factory ProgressEffect.dailyProgressListFetched(
    ResourceStatusEnum status, {
    String? errorMsg,
    String? startDate,
    String? endDate,
    int? page,
    int? pageSize,
    DailyProgressListDto? dailyProgressList,
  }) =>
      DailyProgressListFetched._(
        status,
        errorMsg: errorMsg,
        startDate: startDate,
        endDate: endDate,
        page: page,
        pageSize: pageSize,
        dailyProgressList: dailyProgressList,
      );
}

final class ProgressUpdated extends ProgressEffect {
  final String? date;
  final DailyProgressDto? dailyProgressDto;

  ProgressUpdated._(super.status, {super.errorMsg, this.date, this.dailyProgressDto});
}

final class DailyProgressListFetched extends ProgressEffect {
  final String? startDate;
  final String? endDate;
  final int? page;
  final int? pageSize;
  final DailyProgressListDto? dailyProgressList;

  DailyProgressListFetched._(
    super.status, {
    super.errorMsg,
    this.startDate,
    this.endDate,
    this.page,
    this.pageSize,
    this.dailyProgressList,
  });
}
