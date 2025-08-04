import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/set_subscription_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/network/subscription_network_port.dart';

import '../model/request/set_subscription_request_dto.dart';

class SetSubscriptionNetworkBounds extends HttpBounds<SetSubscriptionDto, ApiWrapper<SetSubscriptionDto?>> {
  final SubscriptionNetworkPort port;
  final SetSubscriptionRequestDto setSubscriptionRequestDto;

  SetSubscriptionNetworkBounds({required this.port, required this.setSubscriptionRequestDto});

  @override
  Future<ApiWrapper<SetSubscriptionDto?>?> fetchFromNetwork() {
    return port.setSubscription(setSubscriptionRequestDto);
  }

  @override
  Future<SetSubscriptionDto?> processResponse(ApiWrapper<SetSubscriptionDto?>? response, {SetSubscriptionDto? data}) async {
    return switch (response) {
      Success<SetSubscriptionDto?>() => response.value,
      _ => data,
    };
  }
}
