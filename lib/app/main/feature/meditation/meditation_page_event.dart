part of 'meditation_page_bloc.dart';

sealed class MeditationPageEvent extends BaseEvent {
  MeditationPageEvent();

  factory MeditationPageEvent.initial() => Initial._();

  factory MeditationPageEvent.meditations({String? searchQuery}) => GetMeditations._(searchQuery);
}

final class Initial extends MeditationPageEvent {
  Initial._();
}

final class GetMeditations extends MeditationPageEvent {
  final String? searchQuery;

  GetMeditations._(this.searchQuery);
}
