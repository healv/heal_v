import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/subscription_history_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/network/subscription_network_port.dart';

class GetSubscriptionHistoryNetworkBounds extends HttpBounds<SubscriptionHistoryDto, ApiWrapper<SubscriptionHistoryDto?>> {
  final SubscriptionNetworkPort port;
  final int? limit;
  final bool? includeZero;

  GetSubscriptionHistoryNetworkBounds({required this.port, this.limit, this.includeZero});

  @override
  Future<ApiWrapper<SubscriptionHistoryDto?>?> fetchFromNetwork() {
    return port.getSubscriptionHistory(limit, includeZero);
  }

  @override
  Future<SubscriptionHistoryDto?> processResponse(ApiWrapper<SubscriptionHistoryDto?>? response, {SubscriptionHistoryDto? data}) async {
    return switch (response) {
      Success<SubscriptionHistoryDto?>() => response.value,
      _ => data,
    };
  }
}
