import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/subscription/network/subscription_network_port.dart';

import '../model/subscription_plan_dto.dart';

class GetSubscriptionPlanNetworkBounds extends HttpBounds<SubscriptionPlanDto, ApiWrapper<SubscriptionPlanDto?>> {
  final SubscriptionNetworkPort port;
  final String subscriptionId;

  GetSubscriptionPlanNetworkBounds({required this.port, required this.subscriptionId});

  @override
  Future<ApiWrapper<SubscriptionPlanDto?>?> fetchFromNetwork() {
    return port.getSubscriptionPlan(subscriptionId);
  }

  @override
  Future<SubscriptionPlanDto?> processResponse(ApiWrapper<SubscriptionPlanDto?>? response, {SubscriptionPlanDto? data}) async {
    return switch (response) {
      Success<SubscriptionPlanDto?>() => response.value,
      _ => data,
    };
  }
}
