import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/meditation/model/meditation_lessons_dto.dart';
import 'package:heal_v/feature/heal_v/api/meditation/network/meditations_network_port.dart';

import '../../../../../app/main/feature/meditation/model/meditation_lessons_ui_model.dart';

class MeditationLessonNetworkBounds extends HttpBounds<MeditationLesson, ApiWrapper<MeditationLessonDto?>> {
  final MeditationsNetworkPort port;
  final String weekId;
  final String lessonId;

  MeditationLessonNetworkBounds({required this.port, required this.weekId, required this.lessonId});

  @override
  Future<ApiWrapper<MeditationLessonDto?>?> fetchFromNetwork() {
    return port.getMeditationLesson(weekId: weekId, lessonId: lessonId);
  }

  @override
  Future<MeditationLesson?> processResponse(ApiWrapper<MeditationLessonDto?>? response, {MeditationLesson? data}) async {
    return switch (response) {
      Success<MeditationLessonDto?>() => MeditationLesson.fromMap(response.value?.toJson() ?? {}),
      _ => data,
    };
  }
}
