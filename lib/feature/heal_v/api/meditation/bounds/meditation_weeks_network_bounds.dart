import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/meditation/model/meditation_week_dto.dart';
import 'package:heal_v/feature/heal_v/api/meditation/network/meditations_network_port.dart';

import '../../../../../app/main/feature/meditation/model/meditation_week_ui_model.dart';

class MeditationWeeksNetworkBounds extends HttpBounds<List<MeditationWeek>, ApiWrapper<List<MeditationWeekDto>?>> {
  final MeditationsNetworkPort port;

  MeditationWeeksNetworkBounds({required this.port});

  @override
  Future<ApiWrapper<List<MeditationWeekDto>?>?> fetchFromNetwork() {
    return port.getMeditationWeeks();
  }

  @override
  Future<List<MeditationWeek>?> processResponse(ApiWrapper<List<MeditationWeekDto>?>? response, {List<MeditationWeek>? data}) async {
    return switch (response) {
      Success<List<MeditationWeekDto>?>() => response.value?.map((element) => MeditationWeek.fromMap(element.toJson())).toList(),
      _ => data,
    };
  }
}
