part of 'audio_page_bloc.dart';

@immutable
class AudioPageState extends BaseState {
  final String? title;
  final String? description;
  final String? previewUrl;

  const AudioPageState._({
    this.title,
    this.description,
    this.previewUrl,
  });

  factory AudioPageState.initial() => const AudioPageState._();

  @override
  List<Object?> get props => [title, description, previewUrl];

  AudioPageState copyWith({
    Optional<String?>? title,
    Optional<String?>? description,
    Optional<String?>? previewUrl,
  }) {
    return AudioPageState._(
      title: title?.isValid == true ? title?.value : this.title,
      description: description?.isValid == true ? description?.value : this.description,
      previewUrl: previewUrl?.isValid == true ? previewUrl?.value : this.previewUrl,
    );
  }
}
