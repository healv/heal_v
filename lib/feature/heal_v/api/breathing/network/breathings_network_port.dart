import 'package:heal_v/feature/heal_v/api/breathing/model/breathing_complete_dto.dart';
import 'package:heal_v/feature/heal_v/api/breathing/model/breathing_week_dto.dart';

import '../../../../../common/utils/network/api_wrapper.dart';
import '../model/breathing_lessons_dto.dart';

abstract interface class BreathingsNetworkPort {
  Future<ApiWrapper<List<BreathingWeekDto>?>> getBreathingWeeks();

  Future<ApiWrapper<BreathingLessonsDto?>> getBreathingLessons({required String weekId});

  Future<ApiWrapper<BreathingLessonDto?>> getBreathingLesson({required String weekId, required String lessonId});

  Future<ApiWrapper<BreathingCompleteDto?>> completeBreathingLesson({required String weekId, required String lessonId});
}
