import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/shared_content/model/shared_content_dto.dart';
import 'package:heal_v/feature/heal_v/api/shared_content/network/shared_content_network_port.dart';

class SharedContentNetworkBounds extends HttpBounds<SharedContentDto, ApiWrapper<SharedContentDto?>> {
  final SharedContentNetworkPort port;

  SharedContentNetworkBounds({required this.port});

  @override
  Future<ApiWrapper<SharedContentDto?>?> fetchFromNetwork() {
    return port.sharedContent();
  }

  @override
  Future<SharedContentDto?> processResponse(ApiWrapper<SharedContentDto?>? response, {SharedContentDto? data}) async {
    return switch (response) {
      Success<SharedContentDto?>() => response.value,
      _ => data,
    };
  }
}
