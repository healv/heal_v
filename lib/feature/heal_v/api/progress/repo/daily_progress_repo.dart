import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/daily_progress_dto.dart';
import 'package:heal_v/feature/heal_v/api/shared_content/model/shared_content_dto.dart';

abstract interface class DailyProgressRepo {
  Stream<Resource<DailyProgressDto>> getDailyProgress({required String authToken});
}
