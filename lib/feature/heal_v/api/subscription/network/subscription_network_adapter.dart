import 'package:heal_v/common/utils/network/api_wrapper.dart';
import 'package:heal_v/common/utils/network/parser.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/cancel_subscription_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/create_subscription_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/resume_subscription_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/subscription_history_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/subscription_status_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/network/subscription_network_port.dart';
import 'package:heal_v/feature/heal_v/api/web_service/heal_v_network_web_service.dart';

base class SubscriptionNetworkAdapter implements SubscriptionNetworkPort {
  final HealVNetworkWebService healVNetworkWebService;

  SubscriptionNetworkAdapter({required this.healVNetworkWebService});

  @override
  Future<ApiWrapper<SubscriptionStatusDto?>> getSubscriptionStatus() {
    return parseHttpResponse<SubscriptionStatusDto>(healVNetworkWebService.getSubscriptionStatus, []);
  }

  @override
  Future<ApiWrapper<CreateSubscriptionDto?>> createSubscription() {
    return parseHttpResponse<CreateSubscriptionDto>(healVNetworkWebService.createSubscription, []);
  }

  @override
  Future<ApiWrapper<SubscriptionHistoryDto?>> getSubscriptionHistory(int? limit, bool? includeZero) {
    return parseHttpResponse<SubscriptionHistoryDto>(healVNetworkWebService.getSubscriptionHistory, [limit, includeZero]);
  }

  @override
  Future<ApiWrapper<CancelSubscriptionDto?>> cancelSubscription() {
    return parseHttpResponse<CancelSubscriptionDto>(healVNetworkWebService.cancelSubscription, []);
  }

  @override
  Future<ApiWrapper<ResumeSubscriptionDto?>> resumeSubscription() {
    return parseHttpResponse<ResumeSubscriptionDto>(healVNetworkWebService.resumeSubscription, []);
  }
}
