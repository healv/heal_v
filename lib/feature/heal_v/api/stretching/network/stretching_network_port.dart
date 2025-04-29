import '../../../../../common/utils/network/api_wrapper.dart';
import '../model/stretching_lessons_dto.dart';
import '../model/stretching_week_dto.dart';

abstract interface class StretchingNetworkPort {
  Future<ApiWrapper<List<StretchingWeekDto>?>> getStretchingWeeks();

  Future<ApiWrapper<StretchingLessonsDto?>> getStretchingLessons({String? id});
}
