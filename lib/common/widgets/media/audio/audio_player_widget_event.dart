part of 'audio_player_widget_bloc.dart';

sealed class AudioPlayerWidgetEvent extends BaseEvent {
  const AudioPlayerWidgetEvent();

  factory AudioPlayerWidgetEvent.initial(String mediaUrl) => _Initial(mediaUrl);

  factory AudioPlayerWidgetEvent.subscribeToPosition() => const _SubscribeToPosition();

  factory AudioPlayerWidgetEvent.subscribeToDuration() => const _SubscribeToDuration();

  factory AudioPlayerWidgetEvent.subscribeToBuffer() => const _SubscribeToBuffer();

  factory AudioPlayerWidgetEvent.subscribeToPlayerState() => const _SubscribeToPlayerState();

  factory AudioPlayerWidgetEvent.play() => const _Play();

  factory AudioPlayerWidgetEvent.pause() => const _Pause();

  factory AudioPlayerWidgetEvent.progressSeek(Duration position) => _ProgressSeek(position: position);

  factory AudioPlayerWidgetEvent.forward10Seconds() => const _Forward10Seconds();

  factory AudioPlayerWidgetEvent.replay10Seconds() => const _Replay10Seconds();

  factory AudioPlayerWidgetEvent.changeVolumeState(bool mute) => _ChangeVolumeState(mute: mute);

  factory AudioPlayerWidgetEvent.subscribeToVolumeState() => const _SubscribeToVolumeState();

  factory AudioPlayerWidgetEvent.changeLoopMode(LoopMode loopMode) => _ChangeLoopMode(loopMode: loopMode);
}

final class _Initial extends AudioPlayerWidgetEvent {
  final String  mediaUrl;

  const _Initial(this.mediaUrl);
}

final class _SubscribeToPosition extends AudioPlayerWidgetEvent {
  const _SubscribeToPosition();
}

final class _SubscribeToDuration extends AudioPlayerWidgetEvent {
  const _SubscribeToDuration();
}

final class _SubscribeToBuffer extends AudioPlayerWidgetEvent {
  const _SubscribeToBuffer();
}

final class _SubscribeToPlayerState extends AudioPlayerWidgetEvent {
  const _SubscribeToPlayerState();
}

final class _Play extends AudioPlayerWidgetEvent {
  const _Play();
}

final class _Pause extends AudioPlayerWidgetEvent {
  const _Pause();
}

final class _ProgressSeek extends AudioPlayerWidgetEvent {
  final Duration position;

  const _ProgressSeek({required this.position});
}

final class _Forward10Seconds extends AudioPlayerWidgetEvent {
  const _Forward10Seconds();
}

final class _Replay10Seconds extends AudioPlayerWidgetEvent {
  const _Replay10Seconds();
}

final class _ChangeVolumeState extends AudioPlayerWidgetEvent {
  final bool mute;

  const _ChangeVolumeState({required this.mute});
}

final class _SubscribeToVolumeState extends AudioPlayerWidgetEvent {
  const _SubscribeToVolumeState();
}

final class _ChangeLoopMode extends AudioPlayerWidgetEvent {
  final LoopMode loopMode;

  const _ChangeLoopMode({required this.loopMode});
}
