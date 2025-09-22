import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/subscription/bounds/cancel_subscription_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/subscription/bounds/set_subscription_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/subscription/bounds/get_subscription_history_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/subscription/bounds/get_subscription_plans_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/subscription/bounds/get_subscription_status_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/subscription/bounds/resume_subscription_network_bounds.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/cancel_subscription_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/set_subscription_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/resume_subscription_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/subscription_history_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/subscription_plan_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/subscription_plans_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/subscription_status_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/network/subscription_network_port.dart';
import 'package:heal_v/feature/heal_v/api/subscription/repo/subscription_repo.dart';

import '../bounds/get_subscription_plan_network_bounds.dart';
import '../model/request/set_subscription_request_dto.dart';

base class SubscriptionRepoImpl implements SubscriptionRepo {
  final SubscriptionNetworkPort port;

  SubscriptionRepoImpl({required this.port});

  @override
  Stream<Resource<SubscriptionStatusDto?>> getSubscriptionStatus() {
    return GetSubscriptionStatusNetworkBounds(port: port).call();
  }

  @override
  Stream<Resource<SubscriptionPlansDto?>> getSubscriptionPlans() {
    return GetSubscriptionPlansNetworkBounds(port: port).call();
  }

  @override
  Stream<Resource<SubscriptionPlanDto?>> getSubscriptionPlan(String subscriptionId) {
    return GetSubscriptionPlanNetworkBounds(port: port, subscriptionId: subscriptionId).call();
  }

  @override
  Stream<Resource<SetSubscriptionDto?>> setSubscription(SetSubscriptionRequestDto createSubscriptionRequestDto) {
    return SetSubscriptionNetworkBounds(port: port, setSubscriptionRequestDto: createSubscriptionRequestDto).call();
  }

  @override
  Stream<Resource<SubscriptionHistoryDto?>> getSubscriptionHistory(int? limit, bool? includeZero) {
    return GetSubscriptionHistoryNetworkBounds(port: port, limit: limit, includeZero: includeZero).call();
  }

  @override
  Stream<Resource<CancelSubscriptionDto?>> cancelSubscription() {
    return CancelSubscriptionNetworkBounds(port: port).call();
  }

  @override
  Stream<Resource<ResumeSubscriptionDto?>> resumeSubscription() {
    return ResumeSubscriptionNetworkBounds(port: port).call();
  }
}
