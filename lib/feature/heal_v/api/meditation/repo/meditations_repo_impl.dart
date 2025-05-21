import 'package:heal_v/app/main/feature/meditation/model/meditation_lessons_ui_model.dart';
import 'package:heal_v/app/main/feature/meditation/model/meditation_week_ui_model.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/meditation/bounds/complete_meditation_lesson_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/meditation/bounds/meditation_weeks_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/meditation/model/meditation_complete_dto.dart';
import 'package:heal_v/feature/heal_v/api/meditation/network/meditations_network_port.dart';
import 'package:heal_v/feature/heal_v/api/meditation/repo/meditations_repo.dart';

import '../bounds/meditation_lesson_network_bounds.dart';
import '../bounds/meditation_lessons_network_bounds.dart';

base class MeditationsRepoImpl implements MeditationsRepo {
  final MeditationsNetworkPort port;

  MeditationsRepoImpl({required this.port});

  @override
  Stream<Resource<List<MeditationWeek>>> getMeditationWeeks({String? searchQuery}) {
    return MeditationWeeksNetworkBounds(port: port).call();
  }

  @override
  Stream<Resource<MeditationLessons?>> getMeditationLessons({required String weekId}) {
    return MeditationLessonsNetworkBounds(port: port, weekId: weekId).call();
  }

  @override
  Stream<Resource<MeditationLesson?>> getMeditationLesson({required String weekId, required String lessonId}) {
    return MeditationLessonNetworkBounds(port: port, weekId: weekId, lessonId: lessonId).call();
  }

  @override
  Stream<Resource<MeditationCompleteDto?>> completeMeditationLesson({required String weekId, required String lessonId}) {
    return CompleteMeditationLessonNetworkBounds(port: port, weekId: weekId, lessonId: lessonId).call();
  }
}
