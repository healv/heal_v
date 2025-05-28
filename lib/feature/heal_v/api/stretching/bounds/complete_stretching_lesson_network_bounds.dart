import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/stretching/model/stretching_complete_dto.dart';
import 'package:heal_v/feature/heal_v/api/stretching/network/stretching_network_port.dart';

class CompleteStretchingLessonNetworkBounds extends HttpBounds<StretchingCompleteDto, ApiWrapper<StretchingCompleteDto?>> {
  final StretchingNetworkPort port;
  final String weekId;
  final String lessonId;

  CompleteStretchingLessonNetworkBounds({required this.port, required this.weekId, required this.lessonId});

  @override
  Future<ApiWrapper<StretchingCompleteDto?>?> fetchFromNetwork() {
    return port.completeStretchingLesson(weekId: weekId, lessonId: lessonId);
  }

  @override
  Future<StretchingCompleteDto?> processResponse(ApiWrapper<StretchingCompleteDto?>? response, {StretchingCompleteDto? data}) async {
    return switch (response) {
      Success<StretchingCompleteDto?>() => response.value,
      _ => data,
    };
  }
}
