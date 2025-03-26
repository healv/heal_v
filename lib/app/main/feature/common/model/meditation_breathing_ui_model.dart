import 'package:json_annotation/json_annotation.dart';

part 'meditation_breathing_ui_model.g.dart';

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

@JsonSerializable()
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

  factory MeditationBreathing.fromMap(Map<String, dynamic> map) {
    return MeditationBreathing(
      id: map['id'],
      name: map['name'],
      author: map['author'],
      category: map['category'],
      photoUrl: map['photoUrl'],
      audioUrl: map['audioUrl'],
      description: map['description'],
      duration: map['duration'],
      preview: map['preview'],
    );
  }

  factory MeditationBreathing.fromJson(Map<String, dynamic> json) {
    return _$MeditationBreathingFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MeditationBreathingToJson(this);
  }
}
