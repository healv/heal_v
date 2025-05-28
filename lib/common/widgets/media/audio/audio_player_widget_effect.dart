part of 'audio_player_widget_bloc.dart';

sealed class AudioPlayerWidgetEffect implements SideEffect {
  const AudioPlayerWidgetEffect();

  factory AudioPlayerWidgetEffect.audioPlayerStateChanged({
    required ProcessingState playerState,
    required LoopMode loopMode,
  }) =>
      AudioPlayerStateChanged(
        playerState: playerState,
        loopMode: loopMode,
      );
}

class AudioPlayerStateChanged extends AudioPlayerWidgetEffect {
  final ProcessingState playerState;
  final LoopMode loopMode;

  AudioPlayerStateChanged({required this.playerState, required this.loopMode});
}
