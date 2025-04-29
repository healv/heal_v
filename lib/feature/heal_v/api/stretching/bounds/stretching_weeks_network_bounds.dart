import 'package:heal_v/app/main/feature/stretching/model/stretching_week_ui_model.dart';
import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/stretching/model/stretching_week_dto.dart';
import 'package:heal_v/feature/heal_v/api/stretching/network/stretching_network_port.dart';

class StretchingWeeksNetworkBounds extends HttpBounds<List<StretchingWeek>, ApiWrapper<List<StretchingWeekDto>?>> {
  final StretchingNetworkPort port;

  StretchingWeeksNetworkBounds({required this.port});

  @override
  Future<ApiWrapper<List<StretchingWeekDto>?>?> fetchFromNetwork() {
    return port.getStretchingWeeks();
  }

  @override
  Future<List<StretchingWeek>?> processResponse(ApiWrapper<List<StretchingWeekDto>?>? response, {List<StretchingWeek>? data}) async {
    return switch (response) {
      Success<List<StretchingWeekDto>?>() => response.value?.map((element) => StretchingWeek.fromMap(element.toJson())).toList(),
      _ => data,
    };
  }
}
