import 'package:heal_v/feature/heal_v/api/progress/model/response/daily_progress_dto.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/tree_growth_dto.dart';

import '../../../../../common/utils/network/api_wrapper.dart';

abstract interface class ProgressNetworkPort {
  Future<ApiWrapper<DailyProgressDto?>> getDailyProgress(String? date);

  Future<ApiWrapper<TreeGrowthDto?>> getTreeGrowth();
}
