import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/create_subscription_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/network/subscription_network_port.dart';

class CreateSubscriptionNetworkBounds extends HttpBounds<CreateSubscriptionDto, ApiWrapper<CreateSubscriptionDto?>> {
  final SubscriptionNetworkPort port;

  CreateSubscriptionNetworkBounds({required this.port});

  @override
  Future<ApiWrapper<CreateSubscriptionDto?>?> fetchFromNetwork() {
    return port.createSubscription();
  }

  @override
  Future<CreateSubscriptionDto?> processResponse(ApiWrapper<CreateSubscriptionDto?>? response, {CreateSubscriptionDto? data}) async {
    return switch (response) {
      Success<CreateSubscriptionDto?>() => response.value,
      _ => data,
    };
  }
}
