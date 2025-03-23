part of 'meditation_page_bloc.dart';

sealed class MeditationPageEvent extends BaseEvent {
  MeditationPageEvent();

  factory MeditationPageEvent.initial() => Initial._();

  factory MeditationPageEvent.meditations() => GetMeditations._();

  factory MeditationPageEvent.filterByCategory({required MeditationsCategoriesDto category}) => FilterByCategory._(category);

  factory MeditationPageEvent.updateCategory({required MeditationsCategoriesDto category}) => UpdateCategory._(category);
}

final class Initial extends MeditationPageEvent {
  Initial._();
}

final class GetMeditations extends MeditationPageEvent {
  GetMeditations._();
}

final class FilterByCategory extends MeditationPageEvent {
  final MeditationsCategoriesDto category;

  FilterByCategory._(this.category);
}

final class UpdateCategory extends MeditationPageEvent {
  final MeditationsCategoriesDto category;

  UpdateCategory._(this.category);
}
