import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../common/dart/optional.dart';

part 'meditation_week_ui_model.g.dart';

@JsonSerializable()
@immutable
class MeditationWeek {
  final String? id;
  final String? title;
  final int? order;

  const MeditationWeek({
    this.id,
    this.title,
    this.order,
  });

  MeditationWeek copyWith({
    Optional<String>? id,
    Optional<String>? title,
    Optional<int>? order,
  }) {
    return MeditationWeek(
      id: id?.isValid == true ? id?.value : this.id,
      title: title?.isValid == true ? title?.value : this.title,
      order: order?.isValid == true ? order?.value : this.order,
    );
  }

  factory MeditationWeek.fromMap(Map<String, dynamic> map) {
    return MeditationWeek(
      id: map['id'],
      title: map['title'],
      order: map['order'],
    );
  }

  factory MeditationWeek.fromJson(Map<String, dynamic> json) {
    return _$MeditationWeekFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MeditationWeekToJson(this);
  }
}
