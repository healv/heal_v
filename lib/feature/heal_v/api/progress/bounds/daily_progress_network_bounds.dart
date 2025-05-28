import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/daily_progress_dto.dart';
import 'package:heal_v/feature/heal_v/api/progress/network/progress_network_port.dart';

class DailyProgressNetworkBounds extends HttpBounds<DailyProgressDto, ApiWrapper<DailyProgressDto?>> {
  final ProgressNetworkPort port;
  final String? date;

  DailyProgressNetworkBounds({required this.port, required this.date});

  @override
  Future<ApiWrapper<DailyProgressDto?>?> fetchFromNetwork() {
    return port.getDailyProgress(date);
  }

  @override
  Future<DailyProgressDto?> processResponse(ApiWrapper<DailyProgressDto?>? response, {DailyProgressDto? data}) async {
    return switch (response) {
      Success<DailyProgressDto?>() => response.value,
      _ => data,
    };
  }
}
