import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

import '../tools/store.dart';
import '../utils/store_key.dart';

extension FirebaseMessagingExtension on bool {
  Future<void> changeFirebaseNotificationSettings() async {
    if (this) {
      await FirebaseMessaging.instance.setAutoInitEnabled(true);
      log("FCM token: ${await FirebaseMessaging.instance.getToken()}");
    } else {
      await FirebaseMessaging.instance.setAutoInitEnabled(false);
      await FirebaseMessaging.instance.deleteToken();
    }

    await Store.set(key: StoreKey.notificationEnable, value: this);
  }
}
