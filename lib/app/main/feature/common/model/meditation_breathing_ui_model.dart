import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../common/dart/optional.dart';
import 'meditation_type_enum.dart';

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
@immutable
class MeditationBreathing {
  final String? id;
  final String? name;
  final String? author;
  final List<MeditationBreathingCategory>? category;
  final List<MeditationBreathingMediaUrl>? photoUrl;
  final List<MeditationBreathingMediaUrl>? audioUrl;
  final String? description;
  final String? duration;
  final String? preview;
  final bool? showDescription;
  final bool? isEnable;
  final MeditationTypeEnum? type;
  final String? demoImage;

  const MeditationBreathing({
    this.id,
    this.name,
    this.author,
    this.category,
    this.photoUrl,
    this.audioUrl,
    this.description,
    this.duration,
    this.preview,
    this.showDescription,
    this.isEnable,
    this.type,
    this.demoImage,
  });

  MeditationBreathing copyWith({
    Optional<String>? id,
    Optional<String>? name,
    Optional<String>? author,
    Optional<List<MeditationBreathingCategory>>? category,
    Optional<List<MeditationBreathingMediaUrl>>? photoUrl,
    Optional<List<MeditationBreathingMediaUrl>>? audioUrl,
    Optional<String>? description,
    Optional<String>? duration,
    Optional<String>? preview,
    Optional<bool>? showDescription,
    Optional<bool>? isEnable,
    Optional<MeditationTypeEnum>? type,
    Optional<String>? demoImage,
  }) {
    return MeditationBreathing(
      id: id?.isValid == true ? id?.value : this.id,
      name: name?.isValid == true ? name?.value : this.name,
      author: author?.isValid == true ? author?.value : this.author,
      category: category?.isValid == true ? category?.value : this.category,
      photoUrl: photoUrl?.isValid == true ? photoUrl?.value : this.photoUrl,
      audioUrl: audioUrl?.isValid == true ? audioUrl?.value : this.audioUrl,
      description: description?.isValid == true ? description?.value : this.description,
      duration: duration?.isValid == true ? duration?.value : this.duration,
      preview: preview?.isValid == true ? preview?.value : this.preview,
      showDescription: showDescription?.isValid == true ? showDescription?.value : this.showDescription,
      isEnable: isEnable?.isValid == true ? isEnable?.value : this.isEnable,
      type: type?.isValid == true ? type?.value : this.type,
      demoImage: demoImage?.isValid == true ? demoImage?.value : this.demoImage,
    );
  }

  factory MeditationBreathing.fromMap(Map<String, dynamic> map) {
    return MeditationBreathing(
      id: map['id'],
      name: map['name'],
      author: map['author'],
      category: map['category'],
      photoUrl: (map['photoUrl'] as List<dynamic>).map((item) => MeditationBreathingMediaUrl.fromMap(item)).toList(),
      audioUrl: (map['audioUrl'] as List<dynamic>).map((item) => MeditationBreathingMediaUrl.fromMap(item)).toList(),
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

@JsonSerializable()
@immutable
class MeditationBreathingCategory {
  final String? id;
  final String? name;

  const MeditationBreathingCategory({
    this.id,
    this.name,
  });

  factory MeditationBreathingCategory.fromMap(Map<String, dynamic> map) {
    return MeditationBreathingCategory(
      id: map['id'],
      name: map['name'],
    );
  }

  factory MeditationBreathingCategory.fromJson(Map<String, dynamic> json) {
    return _$MeditationBreathingCategoryFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MeditationBreathingCategoryToJson(this);
  }
}

@JsonSerializable()
@immutable
class MeditationBreathingMediaUrl {
  final String? downloadURL;
  final int? lastModifiedTS;
  final String? name;
  final String? ref;
  final String? type;

  const MeditationBreathingMediaUrl({
    required this.downloadURL,
    required this.lastModifiedTS,
    required this.name,
    required this.ref,
    required this.type,
  });

  factory MeditationBreathingMediaUrl.fromMap(Map<String, dynamic> map) {
    return MeditationBreathingMediaUrl(
      downloadURL: map['downloadURL'],
      lastModifiedTS: map['lastModifiedTS'],
      name: map['name'],
      ref: map['ref'],
      type: map['type'],
    );
  }

  factory MeditationBreathingMediaUrl.fromJson(Map<String, dynamic> json) {
    return _$MeditationBreathingMediaUrlFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MeditationBreathingMediaUrlToJson(this);
  }
}
