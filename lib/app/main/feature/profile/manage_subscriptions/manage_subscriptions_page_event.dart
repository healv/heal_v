part of 'manage_subscriptions_page_bloc.dart';

abstract class ManageSubscriptionsPageEvent extends BaseEvent {
  const ManageSubscriptionsPageEvent();

  factory ManageSubscriptionsPageEvent.initial() => Initial();

  factory ManageSubscriptionsPageEvent.getSubscriptionStatus() => GetSubscriptionStatus();

  factory ManageSubscriptionsPageEvent.getSubscriptionPlans() => GetSubscriptionPlans();

  factory ManageSubscriptionsPageEvent.getSubscriptionPlan(String subscriptionId) => GetSubscriptionPlan(subscriptionId: subscriptionId);

  factory ManageSubscriptionsPageEvent.createSubscription(String priceId) => SetSubscription(priceId: priceId);

  factory ManageSubscriptionsPageEvent.cancelSubscription() => CancelSubscription();

  factory ManageSubscriptionsPageEvent.resumeSubscription() => ResumeSubscription();
}

final class Initial extends ManageSubscriptionsPageEvent {}

final class GetSubscriptionStatus extends ManageSubscriptionsPageEvent {}

final class GetSubscriptionPlans extends ManageSubscriptionsPageEvent {}

final class GetSubscriptionPlan extends ManageSubscriptionsPageEvent {
  final String subscriptionId;

  GetSubscriptionPlan({required this.subscriptionId});
}

final class SetSubscription extends ManageSubscriptionsPageEvent {
  final String priceId;

  SetSubscription({required this.priceId});
}

final class CancelSubscription extends ManageSubscriptionsPageEvent {}

final class ResumeSubscription extends ManageSubscriptionsPageEvent {}
