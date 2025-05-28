import 'package:heal_v/app/main/feature/breathing/model/breathing_lessons.dart';
import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/breathing/model/breathing_lessons_dto.dart';
import 'package:heal_v/feature/heal_v/api/breathing/network/breathings_network_port.dart';

class BreathingLessonsNetworkBounds extends HttpBounds<BreathingLessons, ApiWrapper<BreathingLessonsDto?>> {
  final BreathingsNetworkPort port;
  final String weekId;

  BreathingLessonsNetworkBounds({required this.port, required this.weekId});

  @override
  Future<ApiWrapper<BreathingLessonsDto?>?> fetchFromNetwork() {
    return port.getBreathingLessons(weekId: weekId);
  }

  @override
  Future<BreathingLessons?> processResponse(ApiWrapper<BreathingLessonsDto?>? response, {BreathingLessons? data}) async {
    return switch (response) {
      Success<BreathingLessonsDto?>() => BreathingLessons.fromMap(response.value?.toJson() ?? {}),
      _ => data,
    };
  }
}
