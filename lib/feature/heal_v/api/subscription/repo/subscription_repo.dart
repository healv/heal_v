import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/cancel_subscription_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/create_subscription_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/resume_subscription_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/subscription_history_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/subscription_plan_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/subscription_status_dto.dart';

import '../model/request/create_subscription_request_dto.dart';

abstract interface class SubscriptionRepo {
  Stream<Resource<SubscriptionStatusDto?>> getSubscriptionStatus();

  Stream<Resource<SubscriptionPlanDto?>> getSubscriptionPlans();

  Stream<Resource<CreateSubscriptionDto?>> createSubscription(CreateSubscriptionRequestDto createSubscriptionRequestDto);

  Stream<Resource<SubscriptionHistoryDto?>> getSubscriptionHistory(int? limit, bool? includeZero);

  Stream<Resource<CancelSubscriptionDto?>> cancelSubscription();

  Stream<Resource<ResumeSubscriptionDto?>> resumeSubscription();
}
