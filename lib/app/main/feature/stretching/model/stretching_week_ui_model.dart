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
  final bool? isAccessible;
  final bool? isCompleted;
  final bool? hasSubscriptionAccess;
  final bool? requiresSubscription;

  const StretchingWeek({
    this.id,
    this.title,
    this.order,
    this.isAccessible,
    this.isCompleted,
    this.hasSubscriptionAccess,
    this.requiresSubscription,
  });

  StretchingWeek copyWith({
    Optional<String?>? id,
    Optional<String?>? title,
    Optional<int?>? order,
    Optional<bool?>? isAccessible,
    Optional<bool?>? isCompleted,
    Optional<bool>? hasSubscriptionAccess,
    Optional<bool>? requiresSubscription,
  }) {
    return StretchingWeek(
      id: id?.isValid == true ? id?.value : this.id,
      title: title?.isValid == true ? title?.value : this.title,
      order: order?.isValid == true ? order?.value : this.order,
      isAccessible: isAccessible?.isValid == true ? isAccessible?.value : this.isAccessible,
      isCompleted: isCompleted?.isValid == true ? isCompleted?.value : this.isCompleted,
      hasSubscriptionAccess: hasSubscriptionAccess?.isValid == true ? hasSubscriptionAccess?.value : this.hasSubscriptionAccess,
      requiresSubscription: requiresSubscription?.isValid == true ? requiresSubscription?.value : this.requiresSubscription,
    );
  }

  factory StretchingWeek.fromMap(Map<String, dynamic> map) {
    return StretchingWeek(
      id: map['id'],
      title: map['title'],
      order: map['order'],
      isAccessible: map['isAccessible'] as bool?,
      isCompleted: map['isCompleted'] as bool?,
      hasSubscriptionAccess: map['hasSubscriptionAccess'] as bool?,
      requiresSubscription: map['requiresSubscription'] as bool?,
    );
  }

  factory StretchingWeek.fromJson(Map<String, dynamic> json) {
    return _$StretchingWeekFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StretchingWeekToJson(this);
  }
}
