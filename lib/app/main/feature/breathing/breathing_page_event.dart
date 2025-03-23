part of 'breathing_page_bloc.dart';

sealed class BreathingPageEvent extends BaseEvent {
  BreathingPageEvent();

  factory BreathingPageEvent.initial() => Initial._();

  factory BreathingPageEvent.updateCategory({required BreathingsCategoriesDto category}) => UpdateCategory._(category);
}

final class Initial extends BreathingPageEvent {
  Initial._();
}

final class UpdateCategory extends BreathingPageEvent {
  final BreathingsCategoriesDto category;

  UpdateCategory._(this.category);
}
