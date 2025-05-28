import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../common/dart/optional.dart';

part 'breathing_week.g.dart';

@JsonSerializable()
@immutable
class BreathingWeek {
  final String? id;
  final String? title;
  final int? order;
  final bool? isAccessible;
  final bool? isCompleted;

  const BreathingWeek({
    this.id,
    this.title,
    this.order,
    this.isAccessible,
    this.isCompleted,
  });

  BreathingWeek copyWith({
    Optional<String>? id,
    Optional<String>? title,
    Optional<int>? order,
    Optional<bool>? isAccessible,
    Optional<bool>? isCompleted,
  }) {
    return BreathingWeek(
      id: id?.isValid == true ? id?.value : this.id,
      title: title?.isValid == true ? title?.value : this.title,
      order: order?.isValid == true ? order?.value : this.order,
      isAccessible: isAccessible?.isValid == true ? isAccessible?.value : this.isAccessible,
      isCompleted: isAccessible?.isValid == true ? isCompleted?.value : this.isCompleted,
    );
  }

  factory BreathingWeek.fromMap(Map<String, dynamic> map) {
    return BreathingWeek(
      id: map['id'],
      title: map['title'],
      order: map['order'] as int?,
      isAccessible: map['isAccessible'] as bool?,
      isCompleted: map['isCompleted'] as bool?,
    );
  }

  factory BreathingWeek.fromJson(Map<String, dynamic> json) {
    return _$BreathingWeekFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BreathingWeekToJson(this);
  }
}
