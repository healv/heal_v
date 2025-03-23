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

  Future<void> _handleUpdateCategoryEvent(UpdateCategory event, Emitter<MeditationPageState> emitter) async {
    emitter(state.copyWith(selectedCategory: Optional.value(event.category)));
  }
}
