import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/breathing/model/breathing_complete_dto.dart';
import 'package:heal_v/feature/heal_v/api/breathing/network/breathings_network_port.dart';

class CompleteBreathingLessonNetworkBounds extends HttpBounds<BreathingCompleteDto, ApiWrapper<BreathingCompleteDto?>> {
  final BreathingsNetworkPort port;
  final String weekId;
  final String lessonId;

  CompleteBreathingLessonNetworkBounds({required this.port, required this.weekId, required this.lessonId});

  @override
  Future<ApiWrapper<BreathingCompleteDto?>?> fetchFromNetwork() {
    return port.completeBreathingLesson(weekId: weekId, lessonId: lessonId);
  }

  @override
  Future<BreathingCompleteDto?> processResponse(ApiWrapper<BreathingCompleteDto?>? response, {BreathingCompleteDto? data}) async {
    return switch (response) {
      Success<BreathingCompleteDto?>() => response.value,
      _ => data,
    };
  }
}
