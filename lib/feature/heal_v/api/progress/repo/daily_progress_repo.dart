import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/daily_progress_dto.dart';

abstract interface class DailyProgressRepo {
  Stream<Resource<DailyProgressDto>> getDailyProgress();
}
