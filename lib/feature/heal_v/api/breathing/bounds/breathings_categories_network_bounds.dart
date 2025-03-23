import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/breathing/model/breathings_categories_dto.dart';
import 'package:heal_v/feature/heal_v/api/breathing/network/breathings_network_port.dart';

class BreathingsCategoriesNetworkBounds extends HttpBounds<List<BreathingsCategoriesDto>, ApiWrapper<List<BreathingsCategoriesDto>?>> {
  final BreathingsNetworkPort port;

  BreathingsCategoriesNetworkBounds({required this.port});

  @override
  Future<ApiWrapper<List<BreathingsCategoriesDto>?>?> fetchFromNetwork() {
    return port.breathingsCategories();
  }

  @override
  Future<List<BreathingsCategoriesDto>?> processResponse(ApiWrapper<List<BreathingsCategoriesDto>?>? response, {List<BreathingsCategoriesDto>? data}) async {
    return switch (response) {
      Success<List<BreathingsCategoriesDto>?>() => response.value,
      _ => data,
    };
  }
}
