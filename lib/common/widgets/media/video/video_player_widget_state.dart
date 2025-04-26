part of 'video_player_widget_bloc.dart';

@immutable
final class VideoPlayerWidgetState extends BaseState {
  final Duration? position;
  final Duration? duration;
  final Duration? buffer;
  final bool? isPlaying;
  final double? volume;

  const VideoPlayerWidgetState._({
    this.position,
    this.duration,
    this.buffer,
    this.isPlaying,
    this.volume,
  });

  factory VideoPlayerWidgetState.initial() => const VideoPlayerWidgetState._();

  @override
  List<Object?> get props => [position, duration, buffer, isPlaying, volume];

  VideoPlayerWidgetState copyWith({
    Optional<Duration?>? position,
    Optional<Duration?>? duration,
    Optional<Duration?>? buffer,
    Optional<bool?>? isPlaying,
    Optional<double?>? volume,
  }) {
    return VideoPlayerWidgetState._(
      position: position?.isValid == true ? position?.value : this.position,
      duration: duration?.isValid == true ? duration?.value : this.duration,
      buffer: buffer?.isValid == true ? buffer?.value : this.buffer,
      isPlaying: isPlaying?.isValid == true ? isPlaying?.value : this.isPlaying,
      volume: volume?.isValid == true ? volume?.value : this.volume,
    );
  }
}
