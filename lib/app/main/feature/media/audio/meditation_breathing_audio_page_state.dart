part of 'meditation_breathing_audio_page_bloc.dart';

@immutable
class MeditationBreathingAudioPageState extends BaseState {
  final MeditationBreathing? item;

  const MeditationBreathingAudioPageState._({
    this.item,
  });

  factory MeditationBreathingAudioPageState.initial() => const MeditationBreathingAudioPageState._();

  @override
  List<Object?> get props => [item];

  MeditationBreathingAudioPageState copyWith({
    Optional<MeditationBreathing?>? item,
  }) {
    return MeditationBreathingAudioPageState._(
      item: item?.isValid == true ? item?.value : this.item,
    );
  }
}
