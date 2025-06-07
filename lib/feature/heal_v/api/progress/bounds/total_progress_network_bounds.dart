import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/total_progress_dto.dart';
import 'package:heal_v/feature/heal_v/api/progress/network/progress_network_port.dart';

class TotalProgressNetworkBounds extends HttpBounds<TotalProgressDto, ApiWrapper<TotalProgressDto?>> {
  final ProgressNetworkPort port;

  TotalProgressNetworkBounds({
    required this.port,
  });

  @override
  Future<ApiWrapper<TotalProgressDto?>?> fetchFromNetwork() {
    return port.totalProgress();
  }

  @override
  Future<TotalProgressDto?> processResponse(ApiWrapper<TotalProgressDto?>? response, {TotalProgressDto? data}) async {
    return switch (response) {
      Success<TotalProgressDto?>() => response.value,
      _ => data,
    };
  }
}
