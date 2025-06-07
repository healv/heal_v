import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/request/daily_progress_request.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/daily_progress_dto.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/daily_progress_list_dto.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/total_progress_dto.dart';

import '../model/response/tree_growth_dto.dart';

abstract interface class ProgressRepo {
  Stream<Resource<DailyProgressDto>> getDailyProgress({String? date});

  Stream<Resource<DailyProgressDto>> updateDailyProgress({String? date, DailyProgressRequest? dailyProgressRequest});

  Stream<Resource<DailyProgressListDto>> getDailyProgressList({
    String? startDate,
    String? endDate,
    int? page,
    int? pageSize,
  });

  Stream<Resource<TotalProgressDto>> totalProgress();

  Stream<Resource<TreeGrowthDto>> getTreeGrowth();
}
