part of 'breathing_page_bloc.dart';

@immutable
final class BreathingPageState extends BaseState {
  final List<BreathingsCategoriesDto>? categories;
  final bool? categoriesLoading;
  final bool? loading;
  final MeditationBreathings? items;
  final BreathingsCategoriesDto? selectedCategory;
  final List<MeditationBreathing>? filteredItems;

  const BreathingPageState._({
    this.categories,
    this.categoriesLoading,
    this.loading,
    this.items,
    this.selectedCategory,
    this.filteredItems,
  });

  factory BreathingPageState.initial() => const BreathingPageState._();

  @override
  List<Object?> get props => [categories, categoriesLoading, loading, items, selectedCategory, filteredItems];

  BreathingPageState copyWith({
    Optional<List<BreathingsCategoriesDto>?>? categories,
    Optional<MeditationBreathings?>? items,
    Optional<bool?>? categoriesLoading,
    Optional<bool?>? loading,
    Optional<BreathingsCategoriesDto?>? selectedCategory,
    Optional<List<MeditationBreathing>?>? filteredItems,
  }) {
    return BreathingPageState._(
      categories: categories?.isValid == true ? categories?.value : this.categories,
      categoriesLoading: categoriesLoading?.isValid == true ? categoriesLoading?.value : this.categoriesLoading,
      loading: loading?.isValid == true ? loading?.value : this.loading,
      items: items?.isValid == true ? items?.value : this.items,
      selectedCategory: selectedCategory?.isValid == true ? selectedCategory?.value : this.selectedCategory,
      filteredItems: filteredItems?.isValid == true ? filteredItems?.value : this.filteredItems,
    );
  }
}
