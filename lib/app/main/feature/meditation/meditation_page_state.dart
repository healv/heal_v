part of 'meditation_page_bloc.dart';

@immutable
final class MeditationPageState extends BaseState {
  final bool? categoriesLoading;
  final bool? loading;
  final MeditationBreathings? items;
  final List<MeditationBreathing>? filteredItems;
  final Map<String, List<MeditationBreathing>>? itemsMap;

  const MeditationPageState._({
    this.categoriesLoading,
    this.loading,
    this.items,
    this.filteredItems,
    this.itemsMap,
  });

  factory MeditationPageState.initial() => const MeditationPageState._();

  @override
  List<Object?> get props => [
        categoriesLoading,
        loading,
        items,
        filteredItems,
        itemsMap,
      ];

  MeditationPageState copyWith({
    Optional<MeditationBreathings?>? items,
    Optional<bool?>? categoriesLoading,
    Optional<bool?>? loading,
    Optional<List<MeditationBreathing>?>? filteredItems,
    Optional<Map<String, List<MeditationBreathing>>?>? itemsMap,
  }) {
    return MeditationPageState._(
      categoriesLoading: categoriesLoading?.isValid == true ? categoriesLoading?.value : this.categoriesLoading,
      loading: loading?.isValid == true ? loading?.value : this.loading,
      items: items?.isValid == true ? items?.value : this.items,
      filteredItems: filteredItems?.isValid == true ? filteredItems?.value : this.filteredItems,
      itemsMap: itemsMap?.isValid == true ? itemsMap?.value : this.itemsMap,
    );
  }
}
