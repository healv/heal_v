import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/main/feature/common/model/meditation_breathing_ui_model.dart';
import 'package:heal_v/common/bloc/base_bloc.dart';
import 'package:heal_v/common/bloc/base_event.dart';
import 'package:heal_v/common/bloc/base_state.dart';
import 'package:heal_v/common/dart/optional.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/breathing/model/breathings_categories_dto.dart';
import 'package:heal_v/feature/heal_v/api/breathing/repo/breathing_repo.dart';

part 'breathing_page_event.dart';
part 'breathing_page_state.dart';

class BreathingPageBloc extends BaseBloc<BreathingPageEvent, BreathingPageState> {
  final BreathingsRepo repo;

  BreathingPageBloc(this.repo) : super(BreathingPageState.initial()) {
    on<Initial>(_handleInitialEvent);
    on<UpdateCategory>(_handleUpdateCategoryEvent);
    on<GetBreathings>(_handleGetBreathingsEvent);
    on<FilterByCategory>(_handleFilterByCategoryEvent);
  }

  Future<void> _handleInitialEvent(Initial event, Emitter<BreathingPageState> emitter) async {
    add(BreathingPageEvent.breathings());
  }

  Future<void> _handleGetBreathingsEvent(GetBreathings event, Emitter<BreathingPageState> emitter) async {
    await for (final response in repo.breathing(searchQuery: event.searchQuery)) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          emitter(state.copyWith(
            loading: const Optional.value(false),
            items: Optional.value(response.data),
          ));
          if (state.selectedCategory != null) {
            add(BreathingPageEvent.filterByCategory(category: state.selectedCategory!));
          }
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

  Future<void> _handleFilterByCategoryEvent(FilterByCategory event, Emitter<BreathingPageState> emitter) async {
    final filteredData = state.items?.meditationBreathing?.where((e) => e.category?.firstWhere((category) => category.name?.trim() == event.category.name?.trim()) != null).toList();
    emitter(state.copyWith(filteredItems: Optional.value(filteredData)));
  }

  Future<void> _handleUpdateCategoryEvent(UpdateCategory event, Emitter<BreathingPageState> emitter) async {
    emitter(state.copyWith(selectedCategory: Optional.value(event.category)));
  }
}
