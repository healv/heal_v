import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/meditation/model/meditation_lessons_dto.dart';
import 'package:heal_v/feature/heal_v/api/meditation/network/meditations_network_port.dart';

import '../../../../../app/main/feature/meditation/model/meditation_lessons_ui_model.dart';

class MeditationLessonsNetworkBounds extends HttpBounds<MeditationLessons, ApiWrapper<MeditationLessonsDto?>> {
  final MeditationsNetworkPort port;
  final String weekId;

  MeditationLessonsNetworkBounds({required this.port, required this.weekId});

  @override
  Future<ApiWrapper<MeditationLessonsDto?>?> fetchFromNetwork() {
    return port.getMeditationLessons(weekId: weekId);
  }

  @override
  Future<MeditationLessons?> processResponse(ApiWrapper<MeditationLessonsDto?>? response, {MeditationLessons? data}) async {
    return switch (response) {
      Success<MeditationLessonsDto?>() => MeditationLessons.fromMap(response.value?.toJson() ?? {}),
      _ => data,
    };
  }
}
