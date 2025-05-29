import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/daily_progress_list_dto.dart';
import 'package:heal_v/feature/heal_v/api/progress/network/progress_network_port.dart';

class DailyProgressListNetworkBounds extends HttpBounds<DailyProgressListDto, ApiWrapper<DailyProgressListDto?>> {
  final ProgressNetworkPort port;
  final String? startDate;
  final String? endDate;
  final int? page;
  final int? pageSize;

  DailyProgressListNetworkBounds({
    required this.port,
    required this.startDate,
    required this.endDate,
    required this.page,
    required this.pageSize,
  });

  @override
  Future<ApiWrapper<DailyProgressListDto?>?> fetchFromNetwork() {
    return port.getDailyProgressList(startDate, endDate, page, pageSize);
  }

  @override
  Future<DailyProgressListDto?> processResponse(ApiWrapper<DailyProgressListDto?>? response, {DailyProgressListDto? data}) async {
    return switch (response) {
      Success<DailyProgressListDto?>() => response.value,
      _ => data,
    };
  }
}
