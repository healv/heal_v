import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/daily_progress_dto.dart';

import '../model/response/tree_growth_dto.dart';

abstract interface class ProgressRepo {
  Stream<Resource<DailyProgressDto>> getDailyProgress({String? date});

  Stream<Resource<TreeGrowthDto>> getTreeGrowth();
}
