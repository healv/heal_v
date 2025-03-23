part of 'meditation_page_bloc.dart';

sealed class MeditationPageEvent extends BaseEvent {
  MeditationPageEvent();

  factory MeditationPageEvent.initial() => Initial._();

  factory MeditationPageEvent.updateCategory({required MeditationsCategoriesDto category}) => UpdateCategory._(category);
}

final class Initial extends MeditationPageEvent {
  Initial._();
}

final class UpdateCategory extends MeditationPageEvent {
  final MeditationsCategoriesDto category;

  UpdateCategory._(this.category);
}
