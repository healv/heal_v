import '../../../../../common/utils/network/api_wrapper.dart';
import '../model/stretching_complete_dto.dart';
import '../model/stretching_lessons_dto.dart';
import '../model/stretching_week_dto.dart';

abstract interface class StretchingNetworkPort {
  Future<ApiWrapper<List<StretchingWeekDto>?>> getStretchingWeeks();

  Future<ApiWrapper<StretchingLessonsDto?>> getStretchingLessons({String? id});

  Future<ApiWrapper<StretchingLessonDto?>> getStretchingLesson({String? weekId, String? lessonId});

  Future<ApiWrapper<StretchingCompleteDto?>> completeStretchingLesson({String? weekId, String? lessonId});
}
