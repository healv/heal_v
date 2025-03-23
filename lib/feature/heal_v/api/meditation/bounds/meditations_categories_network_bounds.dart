import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/meditation/model/meditations_categories_dto.dart';
import 'package:heal_v/feature/heal_v/api/meditation/network/meditations_network_port.dart';

class MeditationsCategoriesNetworkBounds extends HttpBounds<List<MeditationsCategoriesDto>, ApiWrapper<List<MeditationsCategoriesDto>?>> {
  final MeditationsNetworkPort port;

  MeditationsCategoriesNetworkBounds({required this.port});

  @override
  Future<ApiWrapper<List<MeditationsCategoriesDto>?>?> fetchFromNetwork() {
    return port.meditationsCategories();
  }

  @override
  Future<List<MeditationsCategoriesDto>?> processResponse(ApiWrapper<List<MeditationsCategoriesDto>?>? response, {List<MeditationsCategoriesDto>? data}) async {
    return switch (response) {
      Success<List<MeditationsCategoriesDto>?>() => response.value,
      _ => data,
    };
  }
}
