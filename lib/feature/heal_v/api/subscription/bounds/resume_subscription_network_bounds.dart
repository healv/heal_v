import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/bounds/http_bounds.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/resume_subscription_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/network/subscription_network_port.dart';

class ResumeSubscriptionNetworkBounds extends HttpBounds<ResumeSubscriptionDto, ApiWrapper<ResumeSubscriptionDto?>> {
  final SubscriptionNetworkPort port;

  ResumeSubscriptionNetworkBounds({required this.port});

  @override
  Future<ApiWrapper<ResumeSubscriptionDto?>?> fetchFromNetwork() {
    return port.resumeSubscription();
  }

  @override
  Future<ResumeSubscriptionDto?> processResponse(ApiWrapper<ResumeSubscriptionDto?>? response, {ResumeSubscriptionDto? data}) async {
    return switch (response) {
      Success<ResumeSubscriptionDto?>() => response.value,
      _ => data,
    };
  }
}
