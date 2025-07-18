import 'package:heal_v/feature/heal_v/api/subscription/model/cancel_subscription_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/create_subscription_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/resume_subscription_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/subscription_history_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/subscription_plan_dto.dart';

import '../../../../../common/utils/network/api_wrapper.dart';
import '../model/request/create_subscription_request_dto.dart';
import '../model/subscription_status_dto.dart';

abstract interface class SubscriptionNetworkPort {
  Future<ApiWrapper<SubscriptionStatusDto?>> getSubscriptionStatus();

  Future<ApiWrapper<SubscriptionPlanDto?>> getSubscriptionPlans();

  Future<ApiWrapper<CreateSubscriptionDto?>> createSubscription(CreateSubscriptionRequestDto createSubscriptionRequestDto);

  Future<ApiWrapper<SubscriptionHistoryDto?>> getSubscriptionHistory(int? limit, bool? includeZero);

  Future<ApiWrapper<CancelSubscriptionDto?>> cancelSubscription();

  Future<ApiWrapper<ResumeSubscriptionDto?>> resumeSubscription();
}
