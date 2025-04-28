part of 'stretching_video_page_bloc.dart';

sealed class StretchingVideoPageEvent extends BaseEvent {
  const StretchingVideoPageEvent();

  factory StretchingVideoPageEvent.initial() => _Initial();
}

final class _Initial extends StretchingVideoPageEvent {
  const _Initial();
}
