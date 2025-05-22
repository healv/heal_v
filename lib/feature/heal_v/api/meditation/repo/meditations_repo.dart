import 'package:heal_v/app/main/feature/meditation/model/meditation_week.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/meditation/model/meditation_complete_dto.dart';

import '../../../../../app/main/feature/meditation/model/meditation_lessons.dart';

abstract interface class MeditationsRepo {
  Stream<Resource<List<MeditationWeek>>> getMeditationWeeks();

  Stream<Resource<MeditationLessons?>> getMeditationLessons({required String weekId});

  Stream<Resource<MeditationLesson?>> getMeditationLesson({required String weekId, required String lessonId});

  Stream<Resource<MeditationCompleteDto?>> completeMeditationLesson({required String weekId, required String lessonId});
}
