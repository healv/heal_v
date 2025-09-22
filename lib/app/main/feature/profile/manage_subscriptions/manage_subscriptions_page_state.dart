part of 'manage_subscriptions_page_bloc.dart';

@immutable
final class ManageSubscriptionsPageState extends BaseState {
  final SubscriptionStatusDto? subscriptionStatusDto;
  final SetSubscriptionDto? createSubscriptionDto;
  final bool? isSubscriptionStatusLoading;
  final bool? isSubscriptionsPlansLoading;
  final bool? isCreateSubscriptionLoading;
  final bool? isCancelSubscriptionLoading;
  final bool? isResumeSubscriptionLoading;
  final List<SubscriptionPlanItemDto>? plans;
  final SubscriptionPlanItemDto? plan;

  const ManageSubscriptionsPageState._({
    this.subscriptionStatusDto,
    this.createSubscriptionDto,
    this.isSubscriptionStatusLoading,
    this.isSubscriptionsPlansLoading,
    this.isCreateSubscriptionLoading,
    this.isCancelSubscriptionLoading,
    this.isResumeSubscriptionLoading,
    this.plans,
    this.plan,
  });

  factory ManageSubscriptionsPageState.initial() => const ManageSubscriptionsPageState._();

  @override
  List<Object?> get props => [
        subscriptionStatusDto,
        createSubscriptionDto,
        isSubscriptionStatusLoading,
        isSubscriptionsPlansLoading,
        isCreateSubscriptionLoading,
        isCancelSubscriptionLoading,
        isResumeSubscriptionLoading,
        plans,
        plan
      ];

  ManageSubscriptionsPageState copyWith({
    Optional<SubscriptionStatusDto?>? subscriptionStatusDto,
    Optional<SetSubscriptionDto?>? createSubscriptionDto,
    Optional<bool?>? isSubscriptionStatusLoading,
    Optional<bool?>? isSubscriptionsPlansLoading,
    Optional<bool?>? isCreateSubscriptionLoading,
    Optional<bool?>? isCancelSubscriptionLoading,
    Optional<bool?>? isResumeSubscriptionLoading,
    Optional<List<SubscriptionPlanItemDto>?>? plans,
    Optional<SubscriptionPlanItemDto?>? plan,
  }) {
    return ManageSubscriptionsPageState._(
      subscriptionStatusDto: subscriptionStatusDto?.isValid == true ? subscriptionStatusDto?.value : this.subscriptionStatusDto,
      createSubscriptionDto: createSubscriptionDto?.isValid == true ? createSubscriptionDto?.value : this.createSubscriptionDto,
      isSubscriptionStatusLoading: isSubscriptionStatusLoading?.isValid == true ? isSubscriptionStatusLoading?.value : this.isSubscriptionStatusLoading,
      isSubscriptionsPlansLoading: isSubscriptionsPlansLoading?.isValid == true ? isSubscriptionsPlansLoading?.value : this.isSubscriptionsPlansLoading,
      isCreateSubscriptionLoading: isCreateSubscriptionLoading?.isValid == true ? isCreateSubscriptionLoading?.value : this.isCreateSubscriptionLoading,
      isCancelSubscriptionLoading: isCancelSubscriptionLoading?.isValid == true ? isCancelSubscriptionLoading?.value : this.isCancelSubscriptionLoading,
      isResumeSubscriptionLoading: isResumeSubscriptionLoading?.isValid == true ? isResumeSubscriptionLoading?.value : this.isResumeSubscriptionLoading,
      plans: plans?.isValid == true ? plans?.value : this.plans,
      plan: plan?.isValid == true ? plan?.value : this.plan,
    );
  }
}
