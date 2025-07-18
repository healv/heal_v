import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/create_subscription_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/network/subscription_network_port.dart';

import '../model/request/create_subscription_request_dto.dart';

class CreateSubscriptionNetworkBounds extends HttpBounds<CreateSubscriptionDto, ApiWrapper<CreateSubscriptionDto?>> {
  final SubscriptionNetworkPort port;
  final CreateSubscriptionRequestDto createSubscriptionRequestDto;

  CreateSubscriptionNetworkBounds({required this.port, required this.createSubscriptionRequestDto});

  @override
  Future<ApiWrapper<CreateSubscriptionDto?>?> fetchFromNetwork() {
    return port.createSubscription(createSubscriptionRequestDto);
  }

  @override
  Future<CreateSubscriptionDto?> processResponse(ApiWrapper<CreateSubscriptionDto?>? response, {CreateSubscriptionDto? data}) async {
    return switch (response) {
      Success<CreateSubscriptionDto?>() => response.value,
      _ => data,
    };
  }
}
