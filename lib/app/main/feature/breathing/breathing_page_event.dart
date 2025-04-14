part of 'breathing_page_bloc.dart';

sealed class BreathingPageEvent extends BaseEvent {
  BreathingPageEvent();

  factory BreathingPageEvent.initial() => Initial._();

  factory BreathingPageEvent.breathings({String? searchQuery}) => GetBreathings._(searchQuery);

  factory BreathingPageEvent.filterByCategory({required BreathingsCategoriesDto category}) => FilterByCategory._(category);

  factory BreathingPageEvent.updateCategory({required BreathingsCategoriesDto category}) => UpdateCategory._(category);
}

final class Initial extends BreathingPageEvent {
  Initial._();
}

final class GetBreathings extends BreathingPageEvent {
  final String? searchQuery;

  GetBreathings._(this.searchQuery);
}

final class FilterByCategory extends BreathingPageEvent {
  final BreathingsCategoriesDto category;

  FilterByCategory._(this.category);
}

final class UpdateCategory extends BreathingPageEvent {
  final BreathingsCategoriesDto category;

  UpdateCategory._(this.category);
}
