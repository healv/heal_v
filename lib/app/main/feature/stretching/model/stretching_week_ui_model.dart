import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../common/dart/optional.dart';

part 'stretching_week_ui_model.g.dart';

@JsonSerializable()
@immutable
class StretchingWeek {
  final String? id;
  final String? title;
  final int? order;

  const StretchingWeek({
    this.id,
    this.title,
    this.order,
  });

  StretchingWeek copyWith({
    Optional<String>? id,
    Optional<String>? title,
    Optional<int>? order,
  }) {
    return StretchingWeek(
      id: id?.isValid == true ? id?.value : this.id,
      title: title?.isValid == true ? title?.value : this.title,
      order: order?.isValid == true ? order?.value : this.order,
    );
  }

  factory StretchingWeek.fromMap(Map<String, dynamic> map) {
    return StretchingWeek(
      id: map['id'],
      title: map['title'],
      order: map['order'],
    );
  }

  factory StretchingWeek.fromJson(Map<String, dynamic> json) {
    return _$StretchingWeekFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StretchingWeekToJson(this);
  }
}
