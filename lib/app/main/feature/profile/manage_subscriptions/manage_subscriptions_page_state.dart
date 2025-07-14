part of 'manage_subscriptions_page_bloc.dart';

@immutable
final class ManageSubscriptionsPageState extends BaseState {
  final CreateSubscriptionDto? createSubscriptionDto;

  const ManageSubscriptionsPageState._({
    this.createSubscriptionDto,
  });

  factory ManageSubscriptionsPageState.initial() => const ManageSubscriptionsPageState._();

  @override
  List<Object?> get props => [createSubscriptionDto];

  ManageSubscriptionsPageState copyWith({
    Optional<CreateSubscriptionDto?>? createSubscriptionDto,
  }) {
    return ManageSubscriptionsPageState._(
      createSubscriptionDto: createSubscriptionDto?.isValid == true ? createSubscriptionDto?.value : this.createSubscriptionDto,
    );
  }
}
