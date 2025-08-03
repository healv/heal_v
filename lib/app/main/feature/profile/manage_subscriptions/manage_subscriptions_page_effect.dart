part of 'manage_subscriptions_page_bloc.dart';

sealed class ManageSubscriptionsPageEffect implements SideEffect {
  final ResourceStatusEnum status;
  final String? errorMsg;

  const ManageSubscriptionsPageEffect(this.status, {this.errorMsg});

  factory ManageSubscriptionsPageEffect.subscriptionCreated({
    required ResourceStatusEnum status,
    CreateSubscriptionDto? createSubscriptionDto,
    String? errorMsg,
  }) =>
      SubscriptionCreated(status, createSubscriptionDto: createSubscriptionDto, errorMsg: errorMsg);

  factory ManageSubscriptionsPageEffect.subscriptionCancelled({
    required ResourceStatusEnum status,
    String? errorMsg,
  }) =>
      SubscriptionCancelled(status, errorMsg: errorMsg);

  factory ManageSubscriptionsPageEffect.subscriptionResumed({
    required ResourceStatusEnum status,
    String? errorMsg,
  }) =>
      SubscriptionResumed(status, errorMsg: errorMsg);
}

final class SubscriptionCreated extends ManageSubscriptionsPageEffect {
  final CreateSubscriptionDto? createSubscriptionDto;

  SubscriptionCreated(super.status, {this.createSubscriptionDto, super.errorMsg});
}

final class SubscriptionCancelled extends ManageSubscriptionsPageEffect {
  SubscriptionCancelled(super.status, {super.errorMsg});
}

final class SubscriptionResumed extends ManageSubscriptionsPageEffect {
  SubscriptionResumed(super.status, {super.errorMsg});
}
