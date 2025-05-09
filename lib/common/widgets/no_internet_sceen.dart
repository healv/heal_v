import 'dart:async';

import 'package:flutter/material.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/theme/ext/extension.dart';

import '../utils/constants.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  int visibleDot = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        visibleDot = (visibleDot + 1) % 4;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).padding.top,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: context.primary.withValues(alpha: 0.8),
      child: Row(
        children: [
          const Icon(Icons.wifi_off),
          const SizedBox(width: 16),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: tr('you_are_offline'), style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
                TextSpan(
                    style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                    text: visibleDot == 0
                        ? emptyString
                        : visibleDot == 1
                            ? doth
                            : visibleDot == 2
                                ? '$doth$doth'
                                : '$doth$doth$doth'),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }
}
