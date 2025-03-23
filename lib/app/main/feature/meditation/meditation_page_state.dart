part of 'meditation_page_bloc.dart';

@immutable
final class MeditationPageState extends BaseState {
  final List<MeditationsCategoriesDto>? categories;
  final bool? categoriesLoading;
  final bool? loading;
  final List<MeditationBreathings>? items;
  final MeditationsCategoriesDto? selectedCategory;

  const MeditationPageState._({
    this.categories,
    this.categoriesLoading,
    this.loading,
    this.items,
    this.selectedCategory,
  });

  factory MeditationPageState.initial() => const MeditationPageState._();

  @override
  List<Object?> get props => [categories, categoriesLoading, loading, items, selectedCategory];

  MeditationPageState copyWith({
    Optional<List<MeditationsCategoriesDto>?>? categories,
    Optional<List<MeditationBreathings>?>? items,
    Optional<MeditationsCategoriesDto?>? selectedCategory,
    Optional<bool?>? categoriesLoading,
    Optional<bool?>? loading,
  }) {
    return MeditationPageState._(
      categories: categories?.isValid == true ? categories?.value : this.categories,
      categoriesLoading: categoriesLoading?.isValid == true ? categoriesLoading?.value : this.categoriesLoading,
      loading: loading?.isValid == true ? loading?.value : this.loading,
      items: items?.isValid == true ? items?.value : this.items,
      selectedCategory: selectedCategory?.isValid == true ? selectedCategory?.value : this.selectedCategory,
    );
  }
}
