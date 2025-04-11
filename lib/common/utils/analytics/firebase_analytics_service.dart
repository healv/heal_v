import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:heal_v/common/utils/constants.dart';

class FirebaseAnalyticsService {
  static void logEventMeditationSeeAll(String? category) {
    try {
      FirebaseAnalytics.instance.logEvent(
        name: 'home_page_see_all_clicked',
        parameters: {'category': category ?? emptyString},
      );
    } catch (e) {
      debugPrint('Analytics error: $e');
    }
  }
}
