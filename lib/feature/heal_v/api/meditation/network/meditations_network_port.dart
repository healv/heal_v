import 'package:heal_v/feature/heal_v/api/meditation/model/meditation_complete_dto.dart';
import 'package:heal_v/feature/heal_v/api/meditation/model/meditation_week_dto.dart';

import '../../../../../common/utils/network/api_wrapper.dart';
import '../model/meditation_lessons_dto.dart';

abstract interface class MeditationsNetworkPort {
  Future<ApiWrapper<List<MeditationWeekDto>?>> getMeditationWeeks();

  Future<ApiWrapper<MeditationLessonsDto?>> getMeditationLessons({required String weekId});

  Future<ApiWrapper<MeditationLessonDto?>> getMeditationLesson({required String weekId, required String lessonId});

  Future<ApiWrapper<MeditationCompleteDto?>> completeMeditationLesson({required String weekId, required String lessonId});
}
