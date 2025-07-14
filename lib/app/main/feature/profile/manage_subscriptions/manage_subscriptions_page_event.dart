part of 'manage_subscriptions_page_bloc.dart';

abstract class ManageSubscriptionsPageEvent extends BaseEvent {
  const ManageSubscriptionsPageEvent();

  factory ManageSubscriptionsPageEvent.initial() => Initial();

  factory ManageSubscriptionsPageEvent.createSubscription() => CreateSubscription();
}

final class Initial extends ManageSubscriptionsPageEvent {}

final class CreateSubscription extends ManageSubscriptionsPageEvent {}
