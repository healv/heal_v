part of 'audio_page_bloc.dart';

sealed class AudioPageEvent extends BaseEvent {
  const AudioPageEvent();

  factory AudioPageEvent.initial(
    String title,
    String description,
    String previewUrl,
  ) =>
      _Initial(title, description, previewUrl);
}

final class _Initial extends AudioPageEvent {
  final String title;
  final String description;
  final String previewUrl;

  const _Initial(this.title, this.description, this.previewUrl);
}
