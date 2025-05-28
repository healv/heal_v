import 'package:heal_v/app/main/feature/breathing/model/breathing_lessons.dart';
import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/breathing/model/breathing_lessons_dto.dart';
import 'package:heal_v/feature/heal_v/api/breathing/network/breathings_network_port.dart';

class BreathingLessonNetworkBounds extends HttpBounds<BreathingLesson, ApiWrapper<BreathingLessonDto?>> {
  final BreathingsNetworkPort port;
  final String weekId;
  final String lessonId;

  BreathingLessonNetworkBounds({required this.port, required this.weekId, required this.lessonId});

  @override
  Future<ApiWrapper<BreathingLessonDto?>?> fetchFromNetwork() {
    return port.getBreathingLesson(weekId: weekId, lessonId: lessonId);
  }

  @override
  Future<BreathingLesson?> processResponse(ApiWrapper<BreathingLessonDto?>? response, {BreathingLesson? data}) async {
    return switch (response) {
      Success<BreathingLessonDto?>() => BreathingLesson.fromMap(response.value?.toJson() ?? {}),
      _ => data,
    };
  }
}
