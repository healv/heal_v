import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/main/feature/common/model/meditation_breathing_ui_model.dart';
import 'package:heal_v/common/bloc/base_bloc.dart';
import 'package:heal_v/common/bloc/base_event.dart';
import 'package:heal_v/common/bloc/base_state.dart';
import 'package:heal_v/common/dart/optional.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/meditation/model/meditations_categories_dto.dart';
import 'package:heal_v/feature/heal_v/api/meditation/repo/meditations_repo.dart';

part 'meditation_page_event.dart';

part 'meditation_page_state.dart';

class MeditationPageBloc extends BaseBloc<MeditationPageEvent, MeditationPageState> {
  final MeditationsRepo repo;

  MeditationPageBloc(this.repo) : super(MeditationPageState.initial()) {
    on<Initial>(_handleInitialEvent);
    on<UpdateCategory>(_handleUpdateCategoryEvent);
    on<GetMeditations>(_handleGetMeditationsEvent);
    on<FilterByCategory>(_handleFilterByCategoryEvent);
  }

  Future<void> _handleInitialEvent(Initial event, Emitter<MeditationPageState> emitter) async {
    await for (final response in repo.meditationsCategories()) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          emitter(state.copyWith(
            categoriesLoading: const Optional.value(false),
            categories: Optional.value(response.data),
            selectedCategory: Optional.value(response.data?.first),
          ));
          add(MeditationPageEvent.meditations());
          break;
        case ResourceStatusEnum.error:
          emitter(state.copyWith(categoriesLoading: const Optional.value(false)));
          break;
        case ResourceStatusEnum.loading:
          emitter(state.copyWith(categoriesLoading: const Optional.value(true)));
          break;
      }
    }
  }

  Future<void> _handleGetMeditationsEvent(GetMeditations event, Emitter<MeditationPageState> emitter) async {
    await for (final response in repo.meditations()) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          emitter(state.copyWith(
            loading: const Optional.value(false),
            items: Optional.value(response.data),
          ));
          if (state.selectedCategory != null) {
            add(MeditationPageEvent.filterByCategory(category: state.selectedCategory!));
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

  Future<void> _handleFilterByCategoryEvent(FilterByCategory event, Emitter<MeditationPageState> emitter) async {
    final filteredData = state.items?.meditationBreathing?.where((e) => e.category == event.category.name).toList();
    emitter(state.copyWith(filteredItems: Optional.value(filteredData)));
  }

  Future<void> _handleUpdateCategoryEvent(UpdateCategory event, Emitter<MeditationPageState> emitter) async {
    emitter(state.copyWith(selectedCategory: Optional.value(event.category)));
  }
}
