import 'package:heal_v/app/main/feature/stretching/model/stretching_lessons_ui_model.dart';
import 'package:heal_v/app/main/feature/stretching/model/stretching_week_ui_model.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/stretching/model/stretching_complete_dto.dart';

abstract interface class StretchingRepo {
  Stream<Resource<List<StretchingWeek>?>> getStretchingWeeks();

  Stream<Resource<StretchingLessons?>> getStretchingLessons(String id);

  Stream<Resource<StretchingLesson?>> getStretchingLesson(String weekId, String lessonId);

  Stream<Resource<StretchingCompleteDto?>> completeStretchingLesson(String weekId, String lessonId);
}
