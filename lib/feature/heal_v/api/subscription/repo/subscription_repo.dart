import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/cancel_subscription_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/create_subscription_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/resume_subscription_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/subscription_history_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/subscription_status_dto.dart';

abstract interface class SubscriptionRepo {
  Stream<Resource<SubscriptionStatusDto?>> getSubscriptionStatus();

  Stream<Resource<CreateSubscriptionDto?>> createSubscription();

  Stream<Resource<SubscriptionHistoryDto?>> getSubscriptionHistory(int? limit, bool? includeZero);

  Stream<Resource<CancelSubscriptionDto?>> cancelSubscription();

  Stream<Resource<ResumeSubscriptionDto?>> resumeSubscription();
}
