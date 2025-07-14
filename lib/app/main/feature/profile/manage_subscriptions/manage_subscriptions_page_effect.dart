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
}

final class SubscriptionCreated extends ManageSubscriptionsPageEffect {
  final CreateSubscriptionDto? createSubscriptionDto;

  SubscriptionCreated(super.status, {this.createSubscriptionDto, super.errorMsg});
}
