import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/stretching/model/stretching_lessons_dto.dart';
import 'package:heal_v/feature/heal_v/api/stretching/network/stretching_network_port.dart';

import '../../../../../app/main/feature/stretching/model/stretching_lessons_ui_model.dart';

class StretchingLessonNetworkBounds extends HttpBounds<StretchingLesson, ApiWrapper<StretchingLessonDto?>> {
  final StretchingNetworkPort port;
  final String weekId;
  final String lessonId;

  StretchingLessonNetworkBounds({required this.port, required this.weekId, required this.lessonId});

  @override
  Future<ApiWrapper<StretchingLessonDto?>?> fetchFromNetwork() {
    return port.getStretchingLesson(weekId: weekId, lessonId: lessonId);
  }

  @override
  Future<StretchingLesson?> processResponse(ApiWrapper<StretchingLessonDto?>? response, {StretchingLesson? data}) async {
    return switch (response) {
      Success<StretchingLessonDto?>() => StretchingLesson.fromMap(response.value?.toJson() ?? {}),
      _ => data,
    };
  }
}
