import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/bloc/base_event.dart';
import 'package:heal_v/common/bloc/side_effect/side_effect_bloc.dart';
import 'package:heal_v/common/dart/optional.dart';
import 'package:heal_v/feature/heal_v/api/subscription/model/create_subscription_dto.dart';
import 'package:heal_v/feature/heal_v/api/subscription/repo/subscription_repo.dart';

import '../../../../../common/bloc/base_state.dart';
import '../../../../../common/bloc/side_effect/side_effect.dart';
import '../../../../../common/utils/resource.dart';

part 'manage_subscriptions_page_effect.dart';
part 'manage_subscriptions_page_event.dart';
part 'manage_subscriptions_page_state.dart';

class ManageSubscriptionsPageBloc extends SideEffectBloc<ManageSubscriptionsPageEvent, ManageSubscriptionsPageState, ManageSubscriptionsPageEffect> {
  final SubscriptionRepo repo;

  ManageSubscriptionsPageBloc(this.repo) : super(ManageSubscriptionsPageState.initial()) {
    on<Initial>(_handleInitialEvent);
    on<CreateSubscription>(_handleCreateSubscriptionEvent);
  }

  Future<void> _handleInitialEvent(Initial event, Emitter<ManageSubscriptionsPageState> emitter) async {}

  Future<void> _handleCreateSubscriptionEvent(CreateSubscription event, Emitter<ManageSubscriptionsPageState> emitter) async {
    await for (final response in repo.createSubscription()) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          emitter(state.copyWith(createSubscriptionDto: Optional.value(response.data)));
          addSideEffect(ManageSubscriptionsPageEffect.subscriptionCreated(status: ResourceStatusEnum.success, createSubscriptionDto: response.data));
        case ResourceStatusEnum.error:
          break;
        case ResourceStatusEnum.loading:
          break;
      }
    }
  }
}
