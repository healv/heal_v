import 'package:heal_v/app/main/feature/breathing/model/breathing_lessons.dart';
import 'package:heal_v/app/main/feature/breathing/model/breathing_week.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/breathing/model/breathing_complete_dto.dart';

abstract interface class BreathingsRepo {
  Stream<Resource<List<BreathingWeek>>> getBreathingWeeks();

  Stream<Resource<BreathingLessons>> getBreathingLessons({required String weekId});

  Stream<Resource<BreathingLesson>> getBreathingLesson({required String weekId, required String lessonId});

  Stream<Resource<BreathingCompleteDto>> completeBreathingLesson({required String weekId, required String lessonId});
}
