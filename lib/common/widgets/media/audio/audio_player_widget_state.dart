part of 'audio_player_widget_bloc.dart';

@immutable
final class AudioPlayerWidgetState extends BaseState {
  final String? mediaUrl;
  final Duration? position;
  final Duration? duration;
  final Duration? buffer;
  final PlayerState? playerState;
  final double? volume;
  final LoopMode? loopMode;

  const AudioPlayerWidgetState._({
    this.mediaUrl,
    this.position,
    this.duration,
    this.buffer,
    this.playerState,
    this.volume,
    this.loopMode,
  });

  factory AudioPlayerWidgetState.initial() => const AudioPlayerWidgetState._();

  @override
  List<Object?> get props => [mediaUrl, position, duration, buffer, playerState, volume, loopMode];

  AudioPlayerWidgetState copyWith({
    Optional<String?>? mediaUrl,
    Optional<Duration?>? position,
    Optional<Duration?>? duration,
    Optional<Duration?>? buffer,
    Optional<PlayerState?>? playerState,
    Optional<double?>? volume,
    Optional<LoopMode?>? loopMode,
  }) {
    return AudioPlayerWidgetState._(
      mediaUrl: mediaUrl?.isValid == true ? mediaUrl?.value : this.mediaUrl,
      position: position?.isValid == true ? position?.value : this.position,
      duration: duration?.isValid == true ? duration?.value : this.duration,
      buffer: buffer?.isValid == true ? buffer?.value : this.buffer,
      playerState: playerState?.isValid == true ? playerState?.value : this.playerState,
      volume: volume?.isValid == true ? volume?.value : this.volume,
      loopMode: loopMode?.isValid == true ? loopMode?.value : this.loopMode,
    );
  }
}
