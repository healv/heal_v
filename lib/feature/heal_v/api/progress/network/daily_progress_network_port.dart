import 'package:heal_v/feature/heal_v/api/progress/model/response/daily_progress_dto.dart';

import '../../../../../common/utils/network/api_wrapper.dart';

abstract interface class DailyProgressNetworkPort {
  Future<ApiWrapper<DailyProgressDto?>> getDailyProgress(String? authToken);
}
