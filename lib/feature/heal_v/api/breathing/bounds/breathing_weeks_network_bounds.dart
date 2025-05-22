import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/breathing/model/breathing_week_dto.dart';
import 'package:heal_v/feature/heal_v/api/breathing/network/breathings_network_port.dart';

import '../../../../../app/main/feature/breathing/model/breathing_week.dart';

class BreathingWeeksNetworkBounds extends HttpBounds<List<BreathingWeek>, ApiWrapper<List<BreathingWeekDto>?>> {
  final BreathingsNetworkPort port;

  BreathingWeeksNetworkBounds({required this.port});

  @override
  Future<ApiWrapper<List<BreathingWeekDto>?>?> fetchFromNetwork() {
    return port.getBreathingWeeks();
  }

  @override
  Future<List<BreathingWeek>?> processResponse(ApiWrapper<List<BreathingWeekDto>?>? response, {List<BreathingWeek>? data}) async {
    return switch (response) {
      Success<List<BreathingWeekDto>?>() => response.value?.map((element) => BreathingWeek.fromMap(element.toJson())).toList(),
      _ => data,
    };
  }
}
