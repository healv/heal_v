part of 'manage_subscriptions_page_bloc.dart';

@immutable
final class ManageSubscriptionsPageState extends BaseState {
  final SubscriptionStatusDto? subscriptionStatusDto;
  final CreateSubscriptionDto? createSubscriptionDto;
  final bool? isSubscriptionStatusLoading;
  final bool? isSubscriptionsPlansLoading;
  final bool? isCreateSubscriptionLoading;
  final List<SubscriptionPlanItemDto>? plans;
  final SubscriptionPlanItemDto? plan;

  const ManageSubscriptionsPageState._({
    this.subscriptionStatusDto,
    this.createSubscriptionDto,
    this.isSubscriptionStatusLoading,
    this.isSubscriptionsPlansLoading,
    this.isCreateSubscriptionLoading,
    this.plans,
    this.plan,
  });

  factory ManageSubscriptionsPageState.initial() => const ManageSubscriptionsPageState._();

  @override
  List<Object?> get props => [subscriptionStatusDto, createSubscriptionDto, isSubscriptionStatusLoading, isSubscriptionsPlansLoading, isCreateSubscriptionLoading, plans, plan];

  ManageSubscriptionsPageState copyWith({
    Optional<SubscriptionStatusDto?>? subscriptionStatusDto,
    Optional<CreateSubscriptionDto?>? createSubscriptionDto,
    Optional<bool?>? isSubscriptionStatusLoading,
    Optional<bool?>? isSubscriptionsPlansLoading,
    Optional<bool?>? isCreateSubscriptionLoading,
    Optional<List<SubscriptionPlanItemDto>?>? plans,
    Optional<SubscriptionPlanItemDto?>? plan,
  }) {
    return ManageSubscriptionsPageState._(
      subscriptionStatusDto: subscriptionStatusDto?.isValid == true ? subscriptionStatusDto?.value : this.subscriptionStatusDto,
      createSubscriptionDto: createSubscriptionDto?.isValid == true ? createSubscriptionDto?.value : this.createSubscriptionDto,
      isSubscriptionStatusLoading: isSubscriptionStatusLoading?.isValid == true ? isSubscriptionStatusLoading?.value : this.isSubscriptionStatusLoading,
      isSubscriptionsPlansLoading: isSubscriptionsPlansLoading?.isValid == true ? isSubscriptionsPlansLoading?.value : this.isSubscriptionsPlansLoading,
      isCreateSubscriptionLoading: isCreateSubscriptionLoading?.isValid == true ? isCreateSubscriptionLoading?.value : this.isCreateSubscriptionLoading,
      plans: plans?.isValid == true ? plans?.value : this.plans,
      plan: plan?.isValid == true ? plan?.value : this.plan,
    );
  }
}
