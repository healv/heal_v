part of 'audio_player_widget_bloc.dart';

@immutable
final class AudioPlayerWidgetState extends BaseState {
  final MeditationBreathing? item;
  final Duration? position;
  final Duration? duration;
  final Duration? buffer;
  final PlayerState? playerState;
  final double? volume;
  final LoopMode? loopMode;

  const AudioPlayerWidgetState._({
    this.item,
    this.position,
    this.duration,
    this.buffer,
    this.playerState,
    this.volume,
    this.loopMode,
  });

  factory AudioPlayerWidgetState.initial() => const AudioPlayerWidgetState._();

  @override
  List<Object?> get props => [item, position, duration, buffer, playerState, volume, loopMode];

  AudioPlayerWidgetState copyWith({
    Optional<MeditationBreathing?>? item,
    Optional<Duration?>? position,
    Optional<Duration?>? duration,
    Optional<Duration?>? buffer,
    Optional<PlayerState?>? playerState,
    Optional<double?>? volume,
    Optional<LoopMode?>? loopMode,
  }) {
    return AudioPlayerWidgetState._(
      item: item?.isValid == true ? item?.value : this.item,
      position: position?.isValid == true ? position?.value : this.position,
      duration: duration?.isValid == true ? duration?.value : this.duration,
      buffer: buffer?.isValid == true ? buffer?.value : this.buffer,
      playerState: playerState?.isValid == true ? playerState?.value : this.playerState,
      volume: volume?.isValid == true ? volume?.value : this.volume,
      loopMode: loopMode?.isValid == true ? loopMode?.value : this.loopMode,
    );
  }
}
