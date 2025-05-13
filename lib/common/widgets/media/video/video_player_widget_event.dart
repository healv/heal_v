part of 'video_player_widget_bloc.dart';

sealed class VideoPlayerWidgetEvent extends BaseEvent {
  const VideoPlayerWidgetEvent();

  factory VideoPlayerWidgetEvent.initial(String? url) => _Initial(url: url);

  factory VideoPlayerWidgetEvent.positionChanged(Duration position) => _PositionChanged(position: position);

  factory VideoPlayerWidgetEvent.durationChanged(Duration duration) => _DurationChanged(duration: duration);

  factory VideoPlayerWidgetEvent.bufferChanged(Duration buffer) => _BufferChanged(buffer: buffer);

  factory VideoPlayerWidgetEvent.isPlayingChanged(bool isPlaying) => _IsPlayingChanged(isPlaying: isPlaying);

  factory VideoPlayerWidgetEvent.progressSeek(Duration position) => _ProgressSeek(position: position);

  factory VideoPlayerWidgetEvent.changeControllerVolume(bool mute) => _ChangeControllerVolume(mute: mute);

  factory VideoPlayerWidgetEvent.changeVolumeState(double volume) => _ChangeVolumeState(volume: volume);

  factory VideoPlayerWidgetEvent.replay10Seconds() => const _Replay10Seconds();

  factory VideoPlayerWidgetEvent.forward10Seconds() => const _Forward10Seconds();

  factory VideoPlayerWidgetEvent.play() => const _Play();

  factory VideoPlayerWidgetEvent.pause() => const _Pause();

  factory VideoPlayerWidgetEvent.enterFullScreen() => const _EnterFullScreen();
}

final class _Initial extends VideoPlayerWidgetEvent {
  final String? url;

  const _Initial({required this.url});
}

final class _PositionChanged extends VideoPlayerWidgetEvent {
  final Duration position;

  const _PositionChanged({required this.position});
}

final class _DurationChanged extends VideoPlayerWidgetEvent {
  final Duration duration;

  const _DurationChanged({required this.duration});
}

final class _BufferChanged extends VideoPlayerWidgetEvent {
  final Duration buffer;

  const _BufferChanged({required this.buffer});
}

final class _IsPlayingChanged extends VideoPlayerWidgetEvent {
  final bool isPlaying;

  const _IsPlayingChanged({required this.isPlaying});
}

final class _ProgressSeek extends VideoPlayerWidgetEvent {
  final Duration position;

  const _ProgressSeek({required this.position});
}

final class _ChangeControllerVolume extends VideoPlayerWidgetEvent {
  final bool mute;

  const _ChangeControllerVolume({required this.mute});
}

final class _ChangeVolumeState extends VideoPlayerWidgetEvent {
  final double volume;

  const _ChangeVolumeState({required this.volume});
}

final class _Replay10Seconds extends VideoPlayerWidgetEvent {
  const _Replay10Seconds();
}

final class _Forward10Seconds extends VideoPlayerWidgetEvent {
  const _Forward10Seconds();
}

final class _Play extends VideoPlayerWidgetEvent {
  const _Play();
}

final class _Pause extends VideoPlayerWidgetEvent {
  const _Pause();
}

final class _EnterFullScreen extends VideoPlayerWidgetEvent {
  const _EnterFullScreen();
}
