import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/tree_growth_dto.dart';
import 'package:heal_v/feature/heal_v/api/progress/network/progress_network_port.dart';

class TreeGrowthNetworkBounds extends HttpBounds<TreeGrowthDto, ApiWrapper<TreeGrowthDto?>> {
  final ProgressNetworkPort port;

  TreeGrowthNetworkBounds({required this.port});

  @override
  Future<ApiWrapper<TreeGrowthDto?>?> fetchFromNetwork() {
    return port.getTreeGrowth();
  }

  @override
  Future<TreeGrowthDto?> processResponse(ApiWrapper<TreeGrowthDto?>? response, {TreeGrowthDto? data}) async {
    return switch (response) {
      Success<TreeGrowthDto?>() => response.value,
      _ => data,
    };
  }
}
