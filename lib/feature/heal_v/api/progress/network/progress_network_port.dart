import 'package:heal_v/feature/heal_v/api/progress/model/response/daily_progress_dto.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/daily_progress_list_dto.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/tree_growth_dto.dart';

import '../../../../../common/utils/network/api_wrapper.dart';
import '../model/request/daily_progress_request.dart';

abstract interface class ProgressNetworkPort {
  Future<ApiWrapper<DailyProgressDto?>> getDailyProgress(String? date);

  Future<ApiWrapper<DailyProgressDto?>> updateDailyProgress(String? date, DailyProgressRequest? dailyProgressRequest);

  Future<ApiWrapper<DailyProgressListDto?>> getDailyProgressList(
    String? startDate,
    String? endDate,
    int? page,
    int? pageSize,
  );

  Future<ApiWrapper<TreeGrowthDto?>> getTreeGrowth();
}
