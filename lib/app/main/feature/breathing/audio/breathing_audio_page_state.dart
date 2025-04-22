part of 'breathing_audio_page_bloc.dart';

@immutable
class BreathingAudioPageState extends BaseState {
  final MeditationBreathing? meditationBreathing;

  const BreathingAudioPageState._({
    this.meditationBreathing,
  });

  factory BreathingAudioPageState.initial() => const BreathingAudioPageState._();

  @override
  List<Object?> get props => [meditationBreathing];

  BreathingAudioPageState copyWith({
    Optional<MeditationBreathing?>? meditationBreathing,
  }) {
    return BreathingAudioPageState._(
      meditationBreathing: meditationBreathing?.isValid == true ? meditationBreathing?.value : this.meditationBreathing,
    );
  }
}
