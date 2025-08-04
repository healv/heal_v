import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/bloc/base_event.dart';
import 'package:heal_v/common/bloc/side_effect/side_effect_bloc.dart';
import 'package:heal_v/common/dart/optional.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/set_subscription_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/repo/subscription_repo.dart';

import '../../../../../common/bloc/base_state.dart';
import '../../../../../common/bloc/side_effect/side_effect.dart';
import '../../../../../common/utils/resource.dart';
import '../../../../../feature/heal_v/api/subscription/model/request/set_subscription_request_dto.dart';
import '../../../../../feature/heal_v/api/subscription/model/subscription_plans_dto.dart';
import '../../../../../feature/heal_v/api/subscription/model/subscription_status_dto.dart';
import '../../../../../feature/heal_v/api/subscription/model/subscription_status_enum.dart';

part 'manage_subscriptions_page_effect.dart';
part 'manage_subscriptions_page_event.dart';
part 'manage_subscriptions_page_state.dart';

class ManageSubscriptionsPageBloc extends SideEffectBloc<ManageSubscriptionsPageEvent, ManageSubscriptionsPageState, ManageSubscriptionsPageEffect> {
  final SubscriptionRepo repo;

  ManageSubscriptionsPageBloc(this.repo) : super(ManageSubscriptionsPageState.initial()) {
    on<Initial>(_handleInitialEvent);
    on<GetSubscriptionStatus>(_handleGetSubscriptionStatusEvent);
    on<GetSubscriptionPlans>(_handleGetSubscriptionPlansEvent);
    on<GetSubscriptionPlan>(_handleGetSubscriptionPlanEvent);
    on<SetSubscription>(_handleSetSubscriptionEvent);
    on<CancelSubscription>(_handleCancelSubscriptionEvent);
    on<ResumeSubscription>(_handleResumeSubscriptionEvent);
  }

  Future<void> _handleInitialEvent(Initial event, Emitter<ManageSubscriptionsPageState> emitter) async {
    add(ManageSubscriptionsPageEvent.getSubscriptionStatus());
  }

  Future<void> _handleGetSubscriptionStatusEvent(GetSubscriptionStatus event, Emitter<ManageSubscriptionsPageState> emitter) async {
    await for (final response in repo.getSubscriptionStatus()) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          switch (SubscriptionStatusEnum.from(response.data?.status)) {
            case null || SubscriptionStatusEnum.incomplete || SubscriptionStatusEnum.pastDue:
              add(ManageSubscriptionsPageEvent.getSubscriptionPlans());
              break;
            case SubscriptionStatusEnum.active:
              add(ManageSubscriptionsPageEvent.getSubscriptionPlan(response.data?.subscriptionId ?? emptyString));
              break;
            case SubscriptionStatusEnum.canceled:
              if (response.data?.cancelAtPeriodEnd == true) {
                add(ManageSubscriptionsPageEvent.getSubscriptionPlan(response.data?.subscriptionId ?? emptyString));
              } else {
                add(ManageSubscriptionsPageEvent.getSubscriptionPlans());
              }
              break;
          }
          emitter(state.copyWith(
            isSubscriptionStatusLoading: const Optional.value(false),
            subscriptionStatusDto: Optional.value(response.data),
          ));
          break;
        case ResourceStatusEnum.error:
          emitter(state.copyWith(isSubscriptionStatusLoading: const Optional.value(false)));
          break;
        case ResourceStatusEnum.loading:
          emitter(state.copyWith(isSubscriptionStatusLoading: const Optional.value(true)));
          break;
      }
    }
  }

  Future<void> _handleGetSubscriptionPlansEvent(GetSubscriptionPlans event, Emitter<ManageSubscriptionsPageState> emitter) async {
    await for (final response in repo.getSubscriptionPlans()) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          final plans = [SubscriptionPlanItemDto.freePlan(), ...?response.data?.plans];
          emitter(state.copyWith(
            isSubscriptionsPlansLoading: const Optional.value(false),
            plans: Optional.value(plans),
          ));
          break;
        case ResourceStatusEnum.error:
          emitter(state.copyWith(
            isSubscriptionsPlansLoading: const Optional.value(false),
          ));
          break;
        case ResourceStatusEnum.loading:
          emitter(state.copyWith(
            isSubscriptionsPlansLoading: const Optional.value(true),
          ));
          break;
      }
    }
  }

  Future<void> _handleGetSubscriptionPlanEvent(GetSubscriptionPlan event, Emitter<ManageSubscriptionsPageState> emitter) async {
    await for (final response in repo.getSubscriptionPlan(event.subscriptionId)) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          emitter(state.copyWith(
            isSubscriptionsPlansLoading: const Optional.value(false),
            plan: Optional.value(response.data?.plan),
          ));
          break;
        case ResourceStatusEnum.error:
          emitter(state.copyWith(
            isSubscriptionsPlansLoading: const Optional.value(false),
          ));
          break;
        case ResourceStatusEnum.loading:
          emitter(state.copyWith(
            isSubscriptionsPlansLoading: const Optional.value(true),
          ));
          break;
      }
    }
  }

  Future<void> _handleSetSubscriptionEvent(SetSubscription event, Emitter<ManageSubscriptionsPageState> emitter) async {
    await for (final response in repo.setSubscription(SetSubscriptionRequestDto(priceId: event.priceId))) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          emitter(state.copyWith(createSubscriptionDto: Optional.value(response.data), isCreateSubscriptionLoading: const Optional.value(false)));
          addSideEffect(ManageSubscriptionsPageEffect.subscriptionCreated(status: ResourceStatusEnum.success, createSubscriptionDto: response.data));
        case ResourceStatusEnum.error:
          addSideEffect(ManageSubscriptionsPageEffect.subscriptionCreated(status: ResourceStatusEnum.error));
          emitter(state.copyWith(isCreateSubscriptionLoading: const Optional.value(false)));
          break;
        case ResourceStatusEnum.loading:
          emitter(state.copyWith(isCreateSubscriptionLoading: const Optional.value(true)));
          addSideEffect(ManageSubscriptionsPageEffect.subscriptionCreated(status: ResourceStatusEnum.loading));
          break;
      }
    }
  }

  Future<void> _handleCancelSubscriptionEvent(CancelSubscription event, Emitter<ManageSubscriptionsPageState> emitter) async {
    await for (final response in repo.cancelSubscription()) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          add(ManageSubscriptionsPageEvent.getSubscriptionStatus());
          addSideEffect(ManageSubscriptionsPageEffect.subscriptionCancelled(status: ResourceStatusEnum.success));
        case ResourceStatusEnum.error:
          addSideEffect(ManageSubscriptionsPageEffect.subscriptionCancelled(status: ResourceStatusEnum.error));
          break;
        case ResourceStatusEnum.loading:
          addSideEffect(ManageSubscriptionsPageEffect.subscriptionCancelled(status: ResourceStatusEnum.loading));
          break;
      }
    }
  }

  Future<void> _handleResumeSubscriptionEvent(ResumeSubscription event, Emitter<ManageSubscriptionsPageState> emitter) async {
    await for (final response in repo.resumeSubscription()) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          add(ManageSubscriptionsPageEvent.getSubscriptionStatus());
          addSideEffect(ManageSubscriptionsPageEffect.subscriptionResumed(status: ResourceStatusEnum.success));
        case ResourceStatusEnum.error:
          addSideEffect(ManageSubscriptionsPageEffect.subscriptionResumed(status: ResourceStatusEnum.error));
          break;
        case ResourceStatusEnum.loading:
          addSideEffect(ManageSubscriptionsPageEffect.subscriptionResumed(status: ResourceStatusEnum.loading));
          break;
      }
    }
  }
}
