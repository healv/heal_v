class MeditationBreathings {
  final List<MeditationBreathing>? meditationBreathing;
  final dynamic nextCursor;
  final String? prevCursor;

  MeditationBreathings({
    this.meditationBreathing,
    this.nextCursor,
    this.prevCursor,
  });
}

class MeditationBreathing {
  final String? id;
  final String? name;
  final String? author;
  final String? category;
  final String? photoUrl;
  final String? audioUrl;
  final String? description;
  final String? duration;
  final String? preview;

  MeditationBreathing({
    this.id,
    this.name,
    this.author,
    this.category,
    this.photoUrl,
    this.audioUrl,
    this.description,
    this.duration,
    this.preview,
  });
}
