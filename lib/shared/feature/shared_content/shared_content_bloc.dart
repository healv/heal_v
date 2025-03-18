import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/bloc/base_bloc.dart';
import 'package:heal_v/common/bloc/base_event.dart';
import 'package:heal_v/common/dart/optional.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/shared_content/repo/shared_content_repo.dart';

import '../../../common/bloc/base_state.dart';

part 'shared_content_event.dart';

part 'shared_content_state.dart';

class SharedContentBloc extends BaseBloc<SharedContentEvent, SharedContentState> {
  final SharedContentRepo repo;

  SharedContentBloc(this.repo) : super(SharedContentState.initial()) {
    on<Initial>(_handleInitialEvent);
  }

  Future<void> _handleInitialEvent(Initial event, Emitter<SharedContentState> emitter) async {
    await for (final response in repo.sharedContent()) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          emitter(state.copyWith(appBarMessage: Optional.value(response.data?.appBarMessage), loading: const Optional.value(false)));
          break;
        case ResourceStatusEnum.error:
          emitter(state.copyWith(loading: const Optional.value(false)));
          break;
        case ResourceStatusEnum.loading:
          emitter(state.copyWith(loading: const Optional.value(true)));
          break;
      }
    }
  }
}
