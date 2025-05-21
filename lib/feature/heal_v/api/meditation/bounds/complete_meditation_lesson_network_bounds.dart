import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/meditation/model/meditation_complete_dto.dart';
import 'package:heal_v/feature/heal_v/api/meditation/network/meditations_network_port.dart';

class CompleteMeditationLessonNetworkBounds extends HttpBounds<MeditationCompleteDto, ApiWrapper<MeditationCompleteDto?>> {
  final MeditationsNetworkPort port;
  final String weekId;
  final String lessonId;

  CompleteMeditationLessonNetworkBounds({required this.port, required this.weekId, required this.lessonId});

  @override
  Future<ApiWrapper<MeditationCompleteDto?>?> fetchFromNetwork() {
    return port.completeMeditationLesson(weekId: weekId, lessonId: lessonId);
  }

  @override
  Future<MeditationCompleteDto?> processResponse(ApiWrapper<MeditationCompleteDto?>? response, {MeditationCompleteDto? data}) async {
    return switch (response) {
      Success<MeditationCompleteDto?>() => response.value,
      _ => data,
    };
  }
}
