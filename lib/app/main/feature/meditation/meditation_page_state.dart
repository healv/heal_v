part of 'meditation_page_bloc.dart';

@immutable
final class MeditationPageState extends BaseState {
  final List<MeditationsCategoriesDto>? categories;
  final bool? categoriesLoading;
  final bool? loading;
  final MeditationBreathings? items;
  final MeditationsCategoriesDto? selectedCategory;
  final List<MeditationBreathing>? filteredItems;

  const MeditationPageState._({
    this.categories,
    this.categoriesLoading,
    this.loading,
    this.items,
    this.selectedCategory,
    this.filteredItems,
  });

  factory MeditationPageState.initial() => const MeditationPageState._();

  @override
  List<Object?> get props => [categories, categoriesLoading, loading, items, selectedCategory, filteredItems];

  MeditationPageState copyWith({
    Optional<List<MeditationsCategoriesDto>?>? categories,
    Optional<MeditationBreathings?>? items,
    Optional<MeditationsCategoriesDto?>? selectedCategory,
    Optional<bool?>? categoriesLoading,
    Optional<bool?>? loading,
    Optional<List<MeditationBreathing>?>? filteredItems,
  }) {
    return MeditationPageState._(
      categories: categories?.isValid == true ? categories?.value : this.categories,
      categoriesLoading: categoriesLoading?.isValid == true ? categoriesLoading?.value : this.categoriesLoading,
      loading: loading?.isValid == true ? loading?.value : this.loading,
      items: items?.isValid == true ? items?.value : this.items,
      selectedCategory: selectedCategory?.isValid == true ? selectedCategory?.value : this.selectedCategory,
      filteredItems: filteredItems?.isValid == true ? filteredItems?.value : this.filteredItems,
    );
  }
}
