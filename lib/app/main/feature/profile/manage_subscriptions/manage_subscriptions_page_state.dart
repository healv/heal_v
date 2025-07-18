part of 'manage_subscriptions_page_bloc.dart';

@immutable
final class ManageSubscriptionsPageState extends BaseState {
  final CreateSubscriptionDto? createSubscriptionDto;
  final bool? isSubscriptionsPlansLoading;
  final List<SubscriptionPlanItemDto>? plans;

  const ManageSubscriptionsPageState._({
    this.createSubscriptionDto,
    this.isSubscriptionsPlansLoading,
    this.plans,
  });

  factory ManageSubscriptionsPageState.initial() => const ManageSubscriptionsPageState._();

  @override
  List<Object?> get props => [createSubscriptionDto, isSubscriptionsPlansLoading, plans];

  ManageSubscriptionsPageState copyWith({
    Optional<CreateSubscriptionDto?>? createSubscriptionDto,
    Optional<bool?>? isSubscriptionsPlansLoading,
    Optional<List<SubscriptionPlanItemDto>?>? plans,
  }) {
    return ManageSubscriptionsPageState._(
      createSubscriptionDto: createSubscriptionDto?.isValid == true ? createSubscriptionDto?.value : this.createSubscriptionDto,
      isSubscriptionsPlansLoading: isSubscriptionsPlansLoading?.isValid == true ? isSubscriptionsPlansLoading?.value : this.isSubscriptionsPlansLoading,
      plans: plans?.isValid == true ? plans?.value : this.plans,
    );
  }
}
