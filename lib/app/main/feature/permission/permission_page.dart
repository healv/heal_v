import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/theme/ext/extension.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionPage extends StatefulWidget {
  const PermissionPage({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.notifications_active_rounded, color: context.onBackground),
                    const SizedBox(width: 8),
                    Text(tr('notification_permission_description')),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final status = await FirebaseMessaging.instance.requestPermission();
                  if (context.mounted) context.pop<AuthorizationStatus>(status.authorizationStatus);
                },
                child: Text(tr('allow')),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 8.0),
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  context.pop<PermissionStatus>(PermissionStatus.denied);
                },
                child: Text(tr('deny')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
