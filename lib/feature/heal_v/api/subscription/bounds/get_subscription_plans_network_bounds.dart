import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/subscription_plans_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/network/subscription_network_port.dart';

class GetSubscriptionPlansNetworkBounds extends HttpBounds<SubscriptionPlansDto, ApiWrapper<SubscriptionPlansDto?>> {
  final SubscriptionNetworkPort port;

  GetSubscriptionPlansNetworkBounds({required this.port});

  @override
  Future<ApiWrapper<SubscriptionPlansDto?>?> fetchFromNetwork() {
    return port.getSubscriptionPlans();
  }

  @override
  Future<SubscriptionPlansDto?> processResponse(ApiWrapper<SubscriptionPlansDto?>? response, {SubscriptionPlansDto? data}) async {
    return switch (response) {
      Success<SubscriptionPlansDto?>() => response.value,
      _ => data,
    };
  }
}
