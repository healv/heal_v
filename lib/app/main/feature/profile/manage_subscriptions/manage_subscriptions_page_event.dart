part of 'manage_subscriptions_page_bloc.dart';

abstract class ManageSubscriptionsPageEvent extends BaseEvent {
  const ManageSubscriptionsPageEvent();

  factory ManageSubscriptionsPageEvent.initial() => Initial();

  factory ManageSubscriptionsPageEvent.getSubscriptionPlans() => GetSubscriptionPlans();

  factory ManageSubscriptionsPageEvent.createSubscription(String priceId) => CreateSubscription(priceId: priceId);
}

final class Initial extends ManageSubscriptionsPageEvent {}

final class GetSubscriptionPlans extends ManageSubscriptionsPageEvent {}

final class CreateSubscription extends ManageSubscriptionsPageEvent {
  final String priceId;

  CreateSubscription({required this.priceId});
}
