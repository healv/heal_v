import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/breathing/bounds/breathing_lessons_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/breathing/bounds/breathing_weeks_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/breathing/model/breathing_complete_dto.dart';
import 'package:heal_v/feature/heal_v/api/breathing/network/breathings_network_port.dart';
import 'package:heal_v/feature/heal_v/api/breathing/repo/breathing_repo.dart';

import '../../../../../app/main/feature/breathing/model/breathing_lessons.dart';
import '../../../../../app/main/feature/breathing/model/breathing_week.dart';
import '../bounds/breathing_lesson_network_bounds.dart';
import '../bounds/complete_breathing_lesson_network_bounds.dart';

base class BreathingsRepoImpl implements BreathingsRepo {
  final BreathingsNetworkPort port;

  BreathingsRepoImpl({required this.port});

  @override
  Stream<Resource<List<BreathingWeek>>> getBreathingWeeks() {
    return BreathingWeeksNetworkBounds(port: port).call();
  }

  @override
  Stream<Resource<BreathingLessons>> getBreathingLessons({required String weekId}) {
    return BreathingLessonsNetworkBounds(port: port, weekId: weekId).call();
  }

  @override
  Stream<Resource<BreathingLesson>> getBreathingLesson({required String weekId, required String lessonId}) {
    return BreathingLessonNetworkBounds(port: port, weekId: weekId, lessonId: lessonId).call();
  }

  @override
  Stream<Resource<BreathingCompleteDto>> completeBreathingLesson({required String weekId, required String lessonId}) {
    return CompleteBreathingLessonNetworkBounds(port: port, weekId: weekId, lessonId: lessonId).call();
  }
}
