import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/subscription_status_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/network/subscription_network_port.dart';

class GetSubscriptionStatusNetworkBounds extends HttpBounds<SubscriptionStatusDto, ApiWrapper<SubscriptionStatusDto?>> {
  final SubscriptionNetworkPort port;

  GetSubscriptionStatusNetworkBounds({required this.port});

  @override
  Future<ApiWrapper<SubscriptionStatusDto?>?> fetchFromNetwork() {
    return port.getSubscriptionStatus();
  }

  @override
  Future<SubscriptionStatusDto?> processResponse(ApiWrapper<SubscriptionStatusDto?>? response, {SubscriptionStatusDto? data}) async {
    return switch (response) {
      Success<SubscriptionStatusDto?>() => response.value,
      _ => data,
    };
  }
}
