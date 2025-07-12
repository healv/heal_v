import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/cancel_subscription_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/network/subscription_network_port.dart';

class CancelSubscriptionNetworkBounds extends HttpBounds<CancelSubscriptionDto, ApiWrapper<CancelSubscriptionDto?>> {
  final SubscriptionNetworkPort port;

  CancelSubscriptionNetworkBounds({required this.port});

  @override
  Future<ApiWrapper<CancelSubscriptionDto?>?> fetchFromNetwork() {
    return port.cancelSubscription();
  }

  @override
  Future<CancelSubscriptionDto?> processResponse(ApiWrapper<CancelSubscriptionDto?>? response, {CancelSubscriptionDto? data}) async {
    return switch (response) {
      Success<CancelSubscriptionDto?>() => response.value,
      _ => data,
    };
  }
}
