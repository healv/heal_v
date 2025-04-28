part of 'meditation_breathing_audio_page_bloc.dart';

sealed class MeditationBreathingAudioPageEvent extends BaseEvent {
  const MeditationBreathingAudioPageEvent();

  factory MeditationBreathingAudioPageEvent.initial(MeditationBreathing item) => _Initial(item);
}

final class _Initial extends MeditationBreathingAudioPageEvent {
  final MeditationBreathing item;

  const _Initial(this.item);
}
